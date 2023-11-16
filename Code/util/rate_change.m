% Goal: Create training examples 
% x: the rate change between pre and post cue
% y: binary vector on whether the rate has reached a threshold that
% indicates responsiveness to cue 
% the threshold is arbitrary for now

load("tagged_unit_ids.mat")
load('Behavior_Camera_Stim_Struct.mat')
% Constants
samplingRate = 30000;  % 30kHz sampling rate
preCueWindow = 1 * samplingRate;  % 1 second before cue, converted to samples
postCueWindow = 1.5 * samplingRate;  % 1.5 seconds after cue, converted to samples
cueTimes = beh_cam_stim.GoStamps;
uniquechannels = unique(channelID);
rateChange = zeros(1, length(uniquechannels));
preCueDuration = 1;  % in seconds
postCueDuration = 1.5;  % in seconds

for idx = 1:length(uniquechannels)
    channel = uniquechannels(idx);
    channelSpikeTimes = spikeTimes(channelID == channel);
    % For each cue, get the spikes that occurred in the window around the cue
allAlignedSpikeTimes = cell(length(cueTimes), 1);

    for i = 1:length(cueTimes)
        cue = cueTimes(i);
        spikesAroundCue = channelSpikeTimes(channelSpikeTimes > cue - preCueWindow & channelSpikeTimes < cue + postCueWindow);
        alignedSpikeTimes = (spikesAroundCue - cue) ./ samplingRate;  % Convert to seconds relative to cue
        allAlignedSpikeTimes{i} = alignedSpikeTimes;
    end
    % Initialize counts
    preCueSpikeCount = 0;
    postCueSpikeCount = 0;
    
    
    
    % For each trial, count spikes in the pre-cue and post-cue windows
    for i = 1:length(allAlignedSpikeTimes)
        alignedSpikeTimesTrial = allAlignedSpikeTimes{i};
        
        % Count spikes in the pre-cue window
        preCueSpikes = sum(alignedSpikeTimesTrial > -preCueDuration & alignedSpikeTimesTrial < 0);
        preCueSpikeCount = preCueSpikeCount + preCueSpikes;
        
        % Count spikes in the post-cue window
        postCueSpikes = sum(alignedSpikeTimesTrial > 0 & alignedSpikeTimesTrial < postCueDuration);
        postCueSpikeCount = postCueSpikeCount + postCueSpikes;
    end
    
    % Compute firing rate (spikes/second) for pre-cue and post-cue periods
    preCueRate = preCueSpikeCount / (preCueDuration * length(cueTimes));  % total spikes divided by total time in pre-cue
    postCueRate = postCueSpikeCount / (postCueDuration * length(cueTimes));  % total spikes divided by total time in post-cue
    % Store the rate change for this channel
    rateChange(idx) = postCueRate - preCueRate;
end

rateChange = rateChange';
% y = rateChange > 0.5;
% Assuming x contains your rate change data
mean_x = mean(rateChange);
std_x = std(rateChange);

threshold = mean_x + 2 * std_x;

y = (rateChange >= threshold);


% Create a histogram of rateChange
figure; % Create a new figure window
histogram(rateChange, 50); % Histogram with 50 bins
xlabel('Change in Firing Rate (spikes/s)');
ylabel('Number of Channels');
title('Distribution of Firing Rate Changes Across Channels');
grid on;


data_combined = [rateChange y];
writematrix(data_combined, 'rate_Change(0.5thresh).csv');
