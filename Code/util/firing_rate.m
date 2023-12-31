% Firing rate test 

% Quick reminder of data 
% OfflineStartStamps: start of offline in between trial blocks
% OfflineEndStamps: end of offline in between trial blocks
% ChannelID: channel identity of the spike detected at that time point
% SpikeTimes: time at which the spike is detected 
load("Behavior_Camera_Stim_Struct.mat")
load("tagged_unit_ids.mat")
offline_start = beh_cam_stim.OfflineStartStamps;
offline_end = beh_cam_stim.OfflineEndStamps; 
trial_start = [1, offline_end(1)+1, offline_end(2)+1, offline_end(3)+1, offline_end(4)+1, offline_end(5)+1];
trial_end = [offline_start(1)-1, offline_start(2)-1, offline_start(3)-1, offline_start(4)-1, offline_start(5)-1, offline_start(6)-1];

% We would like to look at firing rate in seconds 
% Compute the total length of offline period 
offline_duration = sum(offline_end-offline_start)/30000; %about 8400 seconds
trial_duration = sum(trial_end - trial_start)/30000; %about 1581 seconds 

% this data gives u the which neuron(channel) fired at what time. 
data = [channelID spikeTimes];
% Only consider the corticol_good neuron
isNeuronOfInterest = ismember(data(:, 1), cortical_good);
filteredData = data(isNeuronOfInterest, :);

offline_period=[];
for i = 1:6
    start_i = offline_start(i);
    end_i = offline_end(i); 
    % only care about offline period for now 
    offline_period_i = filteredData(:,2) >=start_i & filteredData(:,2) <=end_i; 
    data_offline_i = filteredData(offline_period_i, :);
    offline_period = [offline_period; data_offline_i];
end 
% change to seconds 
offline_period(:,2) = offline_period(:,2)/30000;

% compute firing rate 
f_rate_offline = zeros(96,2);
f_rate_offline(:,1) = cortical_good; 
for i = 1:length(cortical_good)
    f_rate_offline(i,2)=sum(offline_period(:,1)==cortical_good(i))/offline_duration;
end 

bar(f_rate_offline(:,1),f_rate_offline(:,2))
xlabel('Neuron ID')
ylabel('firing rate per second')
title('Offline Period Firing Rate')

trial_period = [];
for i = 1:6
    start_i = trial_start(i);
    end_i = trial_end(i); 
    % only care about offline period for now 
    trial_period_i = filteredData(:,2) >=start_i & filteredData(:,2) <=end_i; 
    data_trial_i = filteredData(trial_period_i, :);
    trial_period = [trial_period; data_trial_i];
end 
% change to seconds 
trial_period(:,2) = trial_period(:,2)/30000;

% compute firing rate 
f_rate_trial = zeros(96,2);
f_rate_trial(:,1) = cortical_good; 
for i = 1:length(cortical_good)
    f_rate_trial(i,2)=sum(trial_period(:,1)==cortical_good(i))/trial_duration;
end 
bar(f_rate_trial(:,1),f_rate_trial(:,2))
xlabel('Neuron ID')
ylabel('firing rate per second')
title('Trial Period Firing Rate')
