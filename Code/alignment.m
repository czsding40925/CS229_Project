% align this with cues 
% Neural data and lever position data 
% End goal
% For each trial 
    % Let x_1, ..., x_d be neuron firing rate (d=96)
    % p = lever position (average?), which can be a predictor for learning

load("Behavior_Camera_Stim_Struct.mat")
load("tagged_unit_ids.mat")
cueTimes = beh_cam_stim.GoStamps;
% Constants
samplingRate = 30000;  % 30kHz sampling rate
preCueWindow = 1.5 * samplingRate;  % 1 second before cue, converted to samples
postCueWindow = 1.5 * samplingRate;  % 1.5 seconds after cue, converted to samples
% the cue windows might be a little bit arbitrary...
% this data gives u the which neuron(channel) fired at what time. 
data = [channelID spikeTimes];
% Only consider the corticol_good neuron
isNeuronOfInterest = ismember(data(:, 1), cortical_good);
filteredData = data(isNeuronOfInterest, :);
% Create a n*2 matrix (n=100, number of cues) of cue windows 

cue_windows = zeros(length(cueTimes),2);
for i = 1:length(cueTimes)
    this_cueTime = cueTimes(i);
    cue_windows(i,:) = [cueTimes(i)-preCueWindow cueTimes(i)+postCueWindow];
end 

% Try: average lever position 
lever_position = beh_cam_stim.LeverPosition;
% compute average lever position for each cue (Lots of NAN's)
% average_lp = zeros(length(cueTimes),1);
% Try: intiating a cell 
lever_position_per_cue = cell(length(cueTimes),1);
neural_spikes_per_cue = cell(length(cueTimes),1);
for i=1:length(cueTimes)
    current_indices = lever_position(:,1) >= cue_windows(i,1) & lever_position(:,1) <= cue_windows(i,2);
    lever_position_per_cue{i} = lever_position(current_indices, 2);  
    neural_spikes_per_cue{i} = filteredData(current_indices,1);
end 

aligned_data = [lever_position_per_cue, neural_spikes_per_cue];
save("aligned_data.mat",'aligned_data')

% Try third cue
current_index = lever_position(:,1) >= cue_windows(9,1) & lever_position(:,1) <= cue_windows(9,2);
current_lp = lever_position(current_index, 2);
% plot(current_lp)
% Try: spike rate 
 