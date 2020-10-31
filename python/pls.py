import numpy as np
from plsr_model import PLS_Model
import matplotlib
import matplotlib.pyplot as plt
import scipy.io as spio

font = {'family' : 'normal',
        'size'   : 22}

matplotlib.rc('font', **font)

samples = np.array(spio.loadmat('../data/samples/free_initValues.mat')['free_initValues'])
data = np.array(spio.loadmat('../data/results/cluster_labels_24hrs.mat')['labels'])

k = 2

results = data[:,k-2,:].transpose()
# results = data.reshape(-1,1)

samples = np.log10(samples[:,:4])
# results = np.log10(results)

half = 90
# xTrain = samples[:half,:]
# yTrain = results[:half]

xTrain, xTest = samples[:half,:], samples[half:100,:]
yTrain, yTest = results[:half], results[half:]

nComp = 2

model = PLS_Model(nComp,labels=["RJ","SHP2","PPX","PPN"])
model.train(xTrain, yTrain)

rsquared = model.eval(xTest,yTest)
print(rsquared)

# yPred = model.predict(xTest)
# plt.plot(yTest, yPred, 'o')
# plt.text(0.2,0,"R-squared = " + str(rsquared)[:6])
# plt.show()

print(model.vip())
model.plot_vip()

model.plot_components()
model.plot_weights()

