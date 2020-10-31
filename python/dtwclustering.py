import numpy as np
import scipy.io as spio
import multiprocessing as mp
from tslearn.clustering import TimeSeriesKMeans
from tslearn.utils import to_time_series_dataset

n_outputs = 4;
max_clusters = 6;
n_obs = 2;

data = np.array(spio.loadmat('../data/results/outputs_24hrs.mat')['outputs'])
labels = np.empty((n_outputs,max_clusters-1,n_obs))

def cluster(time_series,k):
        print(k)
        model = TimeSeriesKMeans(n_clusters=k, metric="dtw", max_iter=10)
        model.fit(time_series)
        return model.labels_

if __name__ == '__main__':
    pool = mp.Pool(mp.cpu_count())
    for output in range(n_outputs-1):
        print("output " + str(output))
        time_series = to_time_series_dataset(data[output,0:n_obs-1,:])
        labels[output,:,:] = pool.starmap(cluster, [(time_series,k) for k in range(2,max_clusters+1)])

mdic = {"labels":labels}
spio.savemat("../data/results/cluster_labels_24hrs.mat",mdic)
