
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
import scipy.io as spio

responses = np.array(spio.loadmat('../holly_results/lowest_error_responses.mat')['responses'])
shape1_indicies = np.array(spio.loadmat('../holly_results/lowest_error_shape1.mat')['shape1_indicies'])

response_labels = ["Nuclear/cytosolic ratio pSTAT5A","Nuclear/cytosolic ratio pSTAT5B","Relative concentration pSTAT5A","Relative concentration pSTAT5B"]


for res in range(4):

    response = responses[:,:,res]
    boolarray = shape1_indicies[:,res] == 1

    fig,axs = plt.subplots(1,2);
    fig.suptitle(response_labels[res])
    ax1 = axs[0]
    ax2 = axs[1]

    im1 = ax1.imshow(response, interpolation='nearest',extent=[0, 6, 10, 0])
    ax1.yaxis.set_visible(False)
    ax1.set_xlabel("Time (hours)")
    ax1.set_title("Unsorted")

    # ax2.xticks(np.arange(0,6,step=1/360))
    shape1 = response[boolarray,:]
    shape2 = response[~boolarray,:]
    concat = np.concatenate((shape1,shape2))
    im2 = ax2.imshow(concat, interpolation='nearest',extent=[0,6,10,0])
    ax2.yaxis.set_visible(False)
    ax2.set_xlabel("Time (hours)")
    ax2.set_title("Sorted by shape")

    fig.colorbar(im1,orientation='vertical')
    plt.show()

