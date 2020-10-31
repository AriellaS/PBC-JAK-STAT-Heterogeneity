import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics import r2_score
from sklearn.preprocessing import StandardScaler

class PLS_Model():

	def __init__(self, numComp, labels):
		self._numComp = numComp
		self._labels = labels

	def train(self, xTrain, yTrain):
		'''
		Trains the model and produces the various
		matrices.

		Inputs:
			xTrain - input training data
			yTrain - output training data
		'''

		# store training data for later use
		self._xTrain = xTrain
		self._yTrain = yTrain

		# scale training data
		self._xscaler = StandardScaler()
		self._xTrainScaled = self._xscaler.fit_transform(xTrain)

		self._yscaler = StandardScaler()
		self._yTrainScaled = self._yscaler.fit_transform(yTrain)

		# run pls
		[self._B, self._Wstar, self._T,
		 self._U, self._P, self._Q, self._W,
		 self._R2X, self._R2Y] = self.plsr(self._xTrainScaled, self._yTrainScaled, self._numComp)

	def predict(self, xTest):
		xTestScaled = self._xscaler.transform(xTest)
		yPred = xTestScaled*self._B
		yPred = np.array(yPred)
		yPred = self._yscaler.inverse_transform(yPred)

		return yPred

	def eval(self, xTest, yTest):
		yPred = self.predict(xTest)
		r2 = r2_score(yTest, yPred)

		return r2

	def vip(self):
		return self.vipCalc(self._xTrainScaled, self._yTrainScaled, self._T, self._W, self._Q.transpose())

	def vipCalc(self, X, Y, T, W, Q):

		X = np.matrix(X)
		Y = np.matrix(Y)
		T = np.matrix(T)
		W = np.matrix(W)
		Q = np.matrix(Q)

		s = np.diag(T.transpose()*T*Q.transpose()*Q)
		s = s.reshape([-1,1])

		

		_, p = X.shape
		_, h = T.shape

		
		VIP = np.zeros(p)
		for i in range(p):
			weight = np.zeros((h,1))
			for j in range(h):
				weight[j,0] = (W[i,j]/np.linalg.norm(W[:,j]))**2
			weight = np.matrix(weight)
			q = s.transpose()*weight
			VIP[i] = np.sqrt(p*q/np.sum(s))

		return VIP

	def plsr(self, X,Y,A):

		varX = np.sum(np.power(X, 2))
		varY = np.sum(np.power(Y, 2))

		X = np.matrix(X)
		Y = np.matrix(Y)

		n_samples = X.shape[0]
		n_inputs = X.shape[1]
		n_resp = Y.shape[1]


		W = np.matrix(np.zeros((n_inputs, A)))
		T = np.matrix(np.zeros((n_samples, A)))
		P = np.matrix(np.zeros((n_inputs, A)))
		Q = np.matrix(np.zeros((n_resp, A)))
		U = np.matrix(np.zeros((n_samples, A)))

		for i in range(A):
			error = 1
			u = Y[:, 0]
			niter = 0
			while (error > 1e-8) and (niter < 1000):
				w = X.transpose()*u/(u.transpose()*u)
				w = w/np.linalg.norm(w)
				t = X*w
				q = Y.transpose()*t/(t.transpose()*t)
				u1 = Y*q/(q.transpose()*q)
				error = np.linalg.norm(u1 - u)/np.linalg.norm(u)
				u = u1
				niter = niter + 1

			p = X.transpose()*t/(t.transpose()*t)
			X = X - t*p.transpose()
			Y = Y - t*q.transpose()

			W[:, i] = w
			T[:, i] = t
			P[:, i] = p
			Q[:, i] = q
			U[:, i] = u

		R2X = np.diag(T.transpose()*T*P.transpose()*P)/varX
		R2Y = np.diag(T.transpose()*T*Q.transpose()*Q)/varY

		Wstar = W*(P.transpose()*W)**(-1)
		B = Wstar*Q.transpose()
		Q = Q.transpose()

		print(R2X)
		print(R2Y)

		return B, Wstar, T, U, P, Q, W, R2X, R2Y

	def plot_components(self):
		plt.scatter(x=[self._T[:,0]], y=[self._T[:,1]], c=self._yTrain, cmap="viridis")
		plt.show()

	def plot_vip(self):
		VIP = self.vip()
		x = np.arange(len(VIP))

		plt.bar(x,VIP, tick_label=self._labels)
		plt.title('VIP scores')
		plt.show()

	def plot_weights(self):
		x = np.arange(len(self._Wstar))
		print(self._Wstar)
		plt.bar(x, self._Wstar[:,0].A1, tick_label=self._labels)
		plt.title('Weights')
