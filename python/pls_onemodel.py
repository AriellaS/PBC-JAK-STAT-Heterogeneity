
import numpy as np
from plsr_model import PLS_Model
import matplotlib
import matplotlib.pyplot as plt
import scipy.io as spio
from sklearn.metrics import r2_score

font = {'size'   : 10}

matplotlib.rc('font', **font)

free_initvals = np.array(spio.loadmat('../error_ranked_parameters/lowest_error_free_initvalues.mat')['samples'])
responses = np.array(spio.loadmat('../holly_results/lowest_error_responses.mat')['responses'])

response_labels = ["Nuclear/cytosolic\nratio pSTAT5A","Nuclear/cytosolic\nratio pSTAT5B","Relative conc.\npSTAT5A","Relative conc.\npSTAT5B"]
initval_labels = ["RJ","SHP2","PPX","PPN"]

split = 9000
nComp = 2

fig,axs = plt.subplots(4,2,figsize=(6,9))

results = np.log10(responses[:,-1,:])
samples = np.log10(free_initvals)

# results = results.reshape(-1,1)

xTrain, xTest = samples[:split], samples[split:]
yTrain, yTest = results[:split,:], results[split:,:]

model = PLS_Model(nComp,labels=initval_labels)
model.train(xTrain, yTrain)

rsquared = model.eval(xTest,yTest)
print(rsquared)

yPred = model.predict(xTest)

# ax = plt.figure().add_subplot()
for i in range(4):
    rsquared = r2_score(yTest[:,i],yPred[:,i])
    ax = axs[i][0]
    ax.plot(yTest[:,i].flatten(), yPred[:,i].flatten(), 'k.',alpha=0.2)
    xbound = ax.get_xbound()
    ybound = ax.get_ybound()
    newbounds = [min(xbound[0],ybound[0]),max(xbound[1],ybound[1])];
    ax.set_xlim(newbounds[0],newbounds[1])
    ax.set_ylim(newbounds[0],newbounds[1])
    axrange = newbounds[1]-newbounds[0]
    ax.set_aspect('equal')
    ax.set_box_aspect(1)
    ax.plot([0, 1], [0, 1], 'k--', transform=ax.transAxes)
    ax.locator_params(nbins=3)

    ax.annotate("R² = " + str(rsquared)[:6],xy=(newbounds[0]+axrange/3,newbounds[0]+axrange/50))
    ax.set_ylabel(response_labels[i]+"    ",fontweight="bold",fontsize=10)

    model.plot_weights(ax=axs[i][1])



plt.show()

    # create equal bounds on x and y axes
#     xbound = ax.get_xbound()
#     ybound = ax.get_ybound()
#     newbounds = [min(xbound[0],ybound[0]),max(xbound[1],ybound[1])];
#     ax.set_xlim(newbounds[0],newbounds[1])
#     ax.set_ylim(newbounds[0],newbounds[1])
#     axrange = newbounds[1]-newbounds[0]
#     ax.set_aspect('equal')
#     ax.set_box_aspect(1)
#     ax.plot([0, 1], [0, 1], 'k--', transform=ax.transAxes)
#     ax.locator_params(nbins=3)
#
#     ax.annotate("R² = " + str(rsquared)[:6],xy=(newbounds[0]+axrange/3,newbounds[0]+axrange/50))
#     # ax.set_xlabel("Actual")
#     # ax.set_ylabel("Predicted")
#     ax.set_ylabel(response_labels[i]+"    ",fontweight="bold",fontsize=10)
#     # ax.set_title(response_labels[i])
#
#     # model.plot_vip()
#
#     model.plot_weights(ax=axs[i][1])
#
# axs[0][0].set_title("PLS model prediction vs.\nmechanistic model (log₁₀)\n");
# axs[0][1].set_title("Weights\n");
# plt.show()
# plt.savefig("../holly_figures/pls/v5/figure_5.png",dpi=300)

