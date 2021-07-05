import numpy as np
from plsr_model import PLS_Model
import matplotlib
import matplotlib.pyplot as plt
import scipy.io as spio

font = {'family' : 'normal',
        'size'   : 15}

matplotlib.rc('font', **font)

colors = ['#fa0006','#da570e','#15a43f','#129fec','#5c1a8e','#fb009f','C0']

response = 3

# samples = np.array(spio.loadmat('../data/samples/free_initValues.mat')['free_initValues'])
# data = np.array(spio.loadmat('../data/results/outputs_24hrs.mat')['outputs'])
# data = np.array(spio.loadmat('../data/results/timecourse_classification/characteristics_response' + str(response) + '.mat')['characteristics'])

results = data;
# results = data[:,k-2,:].transpose()

feature = 1
color = colors[feature-1]

samples = np.log10(samples[:,:4])
# samples = samples[:,:4]
# results = np.log10(results[:,feature-1])
results = results[:,feature-1]
# results = results[:,361,response]
# results = np.log10(results)

results = results.reshape(-1,1)

split = 9000
# xTrain = samples[:half,:]
# yTrain = results[:half]

xTrain, xTest = samples[:split,:], samples[split:,:]
yTrain, yTest = results[:split], results[split:]

nComp = 2

model = PLS_Model(nComp,labels=["RJ","SHP2","PPX","PPN"])
model.train(xTrain, yTrain)

rsquared = model.eval(xTest,yTest)
print(rsquared)

yPred = model.predict(xTest)
ax = plt.figure().add_subplot()
plt.plot(yTest.flatten(), yPred.flatten(), 'o', c=color)

ax.set_aspect(1./ax.get_data_ratio())
ax.plot([0, 1], [0, 1], 'k--', transform=ax.transAxes)

plt.annotate("R-squared = " + str(rsquared)[:6],xy=(ax.get_xbound()[0],ax.get_ybound()[0])).draggable()
# plt.xlabel("Actual")
# plt.ylabel("Predicted")
# plt.title("Height of peak")
# plt.title("Time of peak")
# plt.title("Height of min")
# plt.title("Time of min")
# plt.title("Relative concentration STAT5A")
# plt.title("Nuclear/cytosolic ratio pSTAT5A")
# plt.title("Nuclear/cytosolic ratio pSTAT5B")
# plt.title("Slope from peak to min")
# plt.title("Slope from min to 6hrs")
plt.show()

# print(model.vip())
model.plot_vip()
# model.plot_vip(color)

model.plot_components()
# model.plot_weights(color)

