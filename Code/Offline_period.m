
% Quick reminder of data 
% OfflineStartStamps: start of offline in between trial blocks
% OfflineEndStamps: end of offline in between trial blocks
% ChannelID: channel identity of the spike detected at that time point
% SpikeTimes: time at which the spike is detected 
load("Behavior_Camera_Stim_Struct.mat")
load("tagged_unit_ids.mat")
% To do
offline_start = beh_cam_stim.OfflineStartStamps;
offline_end = beh_cam_stim.OfflineEndStamps; 

% We would like to look at firing rate in seconds 

% this data gives u the which neuron(channel) fired at what time. 
data = [channelID spikeTimes];
% Only consider the corticol_good neuron
isNeuronOfInterest = ismember(data(:, 1), cortical_good);
filteredData = data(isNeuronOfInterest, :);

% Sample offline period 
for i = 1:6
    start_i = offline_start(i);
    end_i = offline_end(i); 

    % only care about offline period for now 
    offline_period_i = filteredData(:,2) >=start_i & filteredData(:,2) <=end_i; 
    data_offline_i = filteredData(offline_period_i, :);
    data_offline_i(:,2) = data_offline_i(:,2)/30000; % change it to seconds 

    % This plot generates firing patterns during offline period 
    % (The function plots anything but whatever for now) 
    plotNeuronFiring(data_offline_i)
end 






