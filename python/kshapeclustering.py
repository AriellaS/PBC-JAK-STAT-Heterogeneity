import numpy as np
import scipy.io as spio
from tslearn.clustering import KShape

data = np.array(spio.loadmat('../data/results/outputs_24hrs.mat')['outputs'])

