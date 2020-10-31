import numpy as np
import scipy.io as spio
from tslearn.clustering import TimeSeriesKMeans
from tslearn.utils import to_time_series_dataset

n_outputs = 4;
max_clusters = 6;
n_obs = 2;

data = np.array(spio.loadmat('../data/results/outputs_24hrs.mat')['outputs'])
labels = np.empty((n_outputs,max_clusters-1,n_obs))

for output in range(n_outputs-1):
    print("output " + str(output))
    time_series = to_time_series_dataset(data[output,0:n_obs-1,:])
    for k in range(max_clusters-1):
        print("k " + str(k+2))
        model = TimeSeriesKMeans(n_clusters=k+2, metric="dtw", max_iter=10)
        model.fit(time_series)
        labels[output,k,:] = model.labels_

mdic = {"labels":labels}
spio.savemat("../data/results/cluster_labels_24hrs.mat",mdic)
