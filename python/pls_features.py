import numpy as np
from plsr_model import PLS_Model
import matplotlib
import matplotlib.pyplot as plt
import scipy.io as spio

font = {'size'   : 10}

matplotlib.rc('font', **font)

free_initvals = np.array(spio.loadmat('../error_ranked_parameters/lowest_error_free_initvalues.mat')['samples'])
features = np.array(spio.loadmat('../holly_results/lowest_error_features.mat')['features'])
shape1_indicies = np.array(spio.loadmat('../holly_results/lowest_error_shape1.mat')['shape1_indicies'])

response_labels = ["ratio A","ratio B","relative A","relative B"]
feature_labels = ["Height of peak","Height of min","Time of peak","Time of min","Slope from peak to min","Slope from min to 6hrs"];
initval_labels = ["RJ","SHP2","PPX","PPN"]
colors = ["#fa0006","#15a43f","#da570e","#129fec","#5c1a8e","#fb009f"];

split_p = .9
nComp = 2

for i in range(4):
    shape1_index = np.squeeze(shape1_indicies) == 1
    feature = features[shape1_index,:,i]
    initval = free_initvals[shape1_index,:]
    fig,axs = plt.subplots(6,2,figsize=(6,15))
    fig.subplots_adjust(left=0.3,right=1)

    split = int(split_p * feature[:,i].size)
    for j in range(6):
        results = np.log10(feature[:,j])
        samples = np.log10(initval)

        results = results.reshape(-1,1)

        xTrain, xTest = samples[:split], samples[split:]
        yTrain, yTest = results[:split], results[split:]

        model = PLS_Model(nComp,labels=initval_labels)
        model.train(xTrain, yTrain)

        rsquared = model.eval(xTest,yTest)
        # print(rsquared)

        yPred = model.predict(xTest)

        # ax = plt.figure().add_subplot()
        ax = axs[j][0]
        ax.plot(yTest.flatten(), yPred.flatten(), '.',c=colors[j],alpha=0.2)

        # ax.set_aspect(1./ax.get_data_ratio())
        # create equal bounds on x and y axes
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
        # plt.xlabel("Actual")
        # plt.ylabel("Predicted")
        if i < 2:
            ax.set_ylabel("Feature         \n"+str(j+1)+"       ",rotation=0,fontweight="bold",fontsize=14)
        # ax.set_title(feature_labels[j])

        # model.plot_vip()

        model.plot_weights(c=colors[j],ax=axs[j][1])

    axs[0][0].set_title(f"PLS model prediction vs.\nmechanistic model " + response_labels[i] + " (log₁₀)\n");
    axs[0][1].set_title("Weights\n");
    plt.show()
    # if i == 0:
    #     plt.savefig(f"../holly_figures/pls_features/v6/figure_8.png",dpi=300)
    # else:
    #     plt.savefig(f"../holly_figures/pls_features/v6/{i+1}.png",dpi=300)
