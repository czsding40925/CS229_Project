
% Compute spike count for each channel
[unique_channels, ~, channel_indices] = unique(channelID);
spike_count_per_channel = accumarray(channel_indices, 1);

% Plotting
bar(unique_channels, spike_count_per_channel);
xlabel('Channel ID');
ylabel('Spike Count');
title('Spike Count per Channel');
grid on;