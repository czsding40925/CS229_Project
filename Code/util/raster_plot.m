cueTimes = beh_cam_stim.GoStamps;

% Assuming 'spikeTimes' contains the spike times and 'channelID' contains the channel IDs
% Assuming 'cueTimes' contains the cue times

% Constants
samplingRate = 30000;  % 30kHz sampling rate
preCueWindow = 1 * samplingRate;  % 1 second before cue, converted to samples
postCueWindow = 1.5 * samplingRate;  % 1.5 seconds after cue, converted to samples

% Select a specific channel (e.g., channel 5)
channel = cortical_good();
channelSpikeTimes = spikeTimes(channelID == channel);

% For each cue, get the spikes that occurred in the window around the cue
allAlignedSpikeTimes = cell(length(cueTimes), 1);

for i = 1:length(cueTimes)
    cue = cueTimes(i);
    spikesAroundCue = channelSpikeTimes(channelSpikeTimes > cue - preCueWindow & channelSpikeTimes < cue + postCueWindow);
    alignedSpikeTimes = (spikesAroundCue - cue) ./ samplingRate;  % Convert to seconds relative to cue
    allAlignedSpikeTimes{i} = alignedSpikeTimes;
end

% Raster plot
figure;
hold on;
for i = 1:length(allAlignedSpikeTimes)
    plot(allAlignedSpikeTimes{i}, repmat(i, length(allAlignedSpikeTimes{i}), 1), 'b.');
end
xlabel('Time relative to cue (s)');
ylabel('Trial number');
title('Raster plot for channel',cortical_good(5));
hold off;



