%% Quick plotting %%
y = aligned_data{18,1}; % Your 85-element vector

% Create an x-axis vector with 90 evenly spaced points from 0 to 3
x = linspace(0, 3, 90);

% Plot the data
plot(x(1:length(y)), y, 'LineWidth', 2); % Plot only the first 85 points of x

% Labeling the axes
xlabel('Time (seconds)');
ylabel('Lever Position');
title('Lever Position for Trial 19 on 09-12');

% Optionally, if you want to set specific limits for the axes:
xlim([0 3]);

