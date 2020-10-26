import numpy as np
import scipy.io as spio
from tslearn.clustering import TimeSeriesKMeans
from tslearn.utils import to_time_series_dataset

data = np.array(spio.loadmat('../data/results/outputs_24hrs.mat')['outputs'])
labels = np.empty((4,9,100))

for output in range(3):
    print("output " + str(output))
    time_series = to_time_series_dataset(data[output,0:100,:])
    for k in range(2,10):
        print("k " + str(k))
        model = TimeSeriesKMeans(n_clusters=k, metric="dtw", max_iter=10)
        model.fit(time_series)
        labels[output,k-2,:] = model.labels_

mdic = {"labels":labels}
spio.savemat("../data/results/cluster_labels_24hrs.mat",mdic)
