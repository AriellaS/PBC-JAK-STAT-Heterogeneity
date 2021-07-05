import numpy as np
import matplotlib
import matplotlib.pyplot as plt
import scipy.io as spio

font = {'weight' : 'bold',
        'size'   : 20}

matplotlib.rc('font', **font)

# use prl_ppx for ppx and prl_ppn for ppn
# save ppx for just responses 1 and 2, save ppn for all responses
# remember to change axis label
responses = np.array(spio.loadmat('../holly_results/heatmap/prl_ppn_responses.mat')['responses'])
responses_end = responses[:,:,:,-1,:]

means = np.mean(responses_end,axis=2)
stds = np.std(responses_end,axis=2)

response_labels = ["Nuclear/cytosolic ratio pSTAT5A","Nuclear/cytosolic ratio pSTAT5B","Relative concentration pSTAT5A","Relative concentration pSTAT5B"]

factors = [0.1,1,10]
baseline_prl = 200

for response in range(4):

    fig, ax = plt.subplots()
    im = ax.imshow(means[:,:,response])

# We want to show all ticks...
    ax.set_xticks(np.arange(len(factors)))
    ax.set_yticks(np.arange(len(factors)))

# ... and label them with the respective list entries
    ax.set_xticklabels(factors)
    ax.set_yticklabels([factor * baseline_prl for factor in factors])

# Loop over data dimensions and create text annotations.
    for i in range(len(factors)):
        for j in range(len(factors)):

            text = ax.text(j, i, str(means[i, j,response])[:6], ha="center", va="bottom", color="w",fontsize=13)
            text = ax.text(j, i, str(stds[i, j,response])[:6], ha="center", va="top", color="w", fontsize=10)

    ax.set_title(response_labels[response])

    # ax.set_xlabel("PPX (proportion of baseline)")
    ax.set_xlabel("PPN (proportion of baseline)")

    ax.set_ylabel("PRL (ng/mL)")

    fig.colorbar(im,orientation='vertical')

    fig.tight_layout()
    plt.show()
