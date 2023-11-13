% Create Struct To simplify the data we need to worry about 
% We will only be caring about some neurons in the end 
load("Behavior_Camera_Stim_Struct.mat")
load("tagged_unit_ids.mat")
offline_start = beh_cam_stim.OfflineStartStamps;
offline_end = beh_cam_stim.OfflineEndStamps; 
% this data gives u the which neuron(channel) fired at what time. 
data = [channelID spikeTimes];
% Only consider the corticol_good neuron
isNeuronOfInterest = ismember(data(:, 1), cortical_good);
filteredData = data(isNeuronOfInterest, :);

mouse13_0912 = struct('offline_start', beh_cam_stim.OfflineStartStamps, ...
    'offline_end', beh_cam_stim.OfflineEndStamps, ...
    'cortical_good', cortical_good, ...
    'filteredData', filteredData);

save('mouse13_0912.mat');
