# -*- coding: utf-8 -*-
"""
Created on Tue Oct 24 18:29:51 2023

@author: faparicio1

data files should be arranged:
    main data directory\mouse name\dates\data files
    e.g. D:\cs229\sch13\2023_09_15\

"""

import os
from os.path import dirname, join as pjoin
import scipy.io as sio
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

#%% set directories and get file names

i = 1
data_dir =  r'/Users/connording40925/CS229_Project/Data'
mouse = 'sch13'
root_path = pjoin(data_dir, mouse)
dates = os.listdir(root_path)
date = dates[i] # '2023_09_15' # 
root_path = pjoin(data_dir, mouse, date)
file_names = sorted(os.listdir(root_path))
samp_rate = 30000

#%% load data for a session

beh_path = pjoin(root_path, 'Behavior_Camera_Stim_Struct.mat')
neural_path = pjoin(root_path, 'tagged_unit_ids.mat')
beh_data = sio.loadmat(beh_path)
beh_data = beh_data['beh_cam_stim']
neural_data = sio.loadmat(neural_path)

#%% reformat the data structures (data is in weird format after loading from matlab file)

neural_data = {key: np.squeeze(neural_data[key]) 
               for key in neural_data.keys() if key[0] is not '_'}

beh_data = {key: np.squeeze(beh_data[key][0,0]) 
            for key in beh_data.dtype.names}

#%% get putatative spike information 

good_channels = np.unique(neural_data['cortical_good'])
spike_times = neural_data['spikeTimes']
channel_ids = neural_data['channelID']

#%% create spikes dataframe

spikes_pd = pd.DataFrame(np.zeros([spike_times.shape[0], good_channels.shape[0]], 
                         dtype=np.int8), columns=good_channels, index=spike_times)

for chan in good_channels:
    inds = channel_ids == chan 
    spikes_pd.loc[inds, chan] = 1

#%% plot spike data for all units around one of the lever movements

plt.figure()
i = 5
idx = np.argmin(abs(beh_data['HitStamps'][i] - spikes_pd.index))
plt.imshow(spikes_pd.values[int(idx-(samp_rate/4)):int(idx+(samp_rate/4))].T, 
           aspect='auto', interpolation='none')
plt.vlines((samp_rate/4), 0, spikes_pd.shape[1]) # plot line at lever movement time

#%%

