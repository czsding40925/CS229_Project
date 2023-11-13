
% Quick reminder of data 
% OfflineStartStamps: start of offline in between trial blocks
% OfflineEndStamps: end of offline in between trial blocks
% ChannelID: channel identity of the spike detected at that time point
% SpikeTimes: time at which the spike is detected 
load("Behavior_Camera_Stim_Struct.mat")
load("tagged_unit_ids.mat")
offline_start = beh_cam_stim.OfflineStartStamps;
offline_end = beh_cam_stim.OfflineEndStamps; 

% We would like to look at firing rate in seconds 

% this data gives u the which neuron(channel) fired at what time. 
data = [channelID spikeTimes];
% Only consider the corticol_good neuron
isNeuronOfInterest = ismember(data(:, 1), cortical_good);
filteredData = data(isNeuronOfInterest, :);

% Sample trial period 
for i = 1:5
    if i == 1
        start_i = 1; 
    else
        start_i = offline_end(i)+1;
    end_i = offline_start(i+1)-1;
    end  

    % only care about offline period for now 
    trial_period_i = filteredData(:,2) >=start_i & filteredData(:,2) <=end_i; 
    data_trial_i = filteredData(trial_period_i, :);
    data_trial_i(:,2) = data_trial_i(:,2)/30000; % change it to seconds 

    % This plot generates firing patterns during offline period 
    % (The function plots anything but whatever for now) 
    plotNeuronFiring(data_trial_i)
end 

