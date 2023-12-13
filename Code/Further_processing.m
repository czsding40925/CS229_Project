% Further Data Processing
% Calculate mean accuracy/F1 score 
% Plots and Stuff 
data_summaries = {'data_summary_09_12.mat','data_summary_09_14.mat','data_summary_09_15.mat'};
F1_scores = zeros(4,3);
Mean_accuracy = zeros(4,3);

for i = 1:3
    this_data = load(data_summaries{i});
    
    % Get the field names of the loaded data
    data_fieldnames = fieldnames(this_data);
    
    % Assuming there's only one field per loaded file
    if length(data_fieldnames) == 1
        struct_name = data_fieldnames{1};
        
        % Access the fields from the struct
        F1 = this_data.(struct_name).F1;
        F1_scores(:,i) = this_data.(struct_name).F1;
        Mean_accuracy(:,i) = this_data.(struct_name).Accuracy;
    else
        error('Unexpected number of fields in the loaded data');
    end
end

% Average of F1_scores across columns
average_F1_scores = mean(F1_scores,2);

% Average of Mean_accuracy across columns
average_Mean_accuracy = mean(Mean_accuracy,2);

% Load the confusion matrices
CF_0912 = load('CF_0912.mat').CF_0912;
CF_0914 = load('CF_0914.mat').CF_0914;
CF_0915 = load('CF_0915.mat').CF_0915;

datasets = {'09/12', '09/14', '09/15'};
models = fieldnames(CF_0912);
allCFs = {CF_0912, CF_0914, CF_0915};

for i = 1:length(datasets)
    % Create a new figure for each dataset
    figure('Name', ['Confusion Matrices - ', datasets{i}], 'NumberTitle', 'off', 'Position', [100, 100, 1500, 900]);
    
    for j = 1:length(models)
        % Select a subplot position
        subplot(2, 2, j); % Assuming you have the same number of models for each dataset

        % Get the confusion matrix for the current model
        CM = allCFs{i}.(models{j});

        % Plot the confusion matrix using heatmap
        heatmap(CM); % Assuming the labels are the same as the model names
        title([models{j}, ' - ', datasets{i}]);

        % Optional: Customize the plot, e.g., set axis labels
        xlabel('Predicted Class');
        ylabel('True Class');
    end
    
    % Optional: Adjust layout
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 1, 1]);
end

% 
%% Create the bar plot
Model_names = {'Logistic Regression', 'Decision Tree','GDA', 'NeuralNetwork'};
figure;
bar([average_Mean_accuracy'; average_F1_scores']');
set(gca, 'xticklabel', Model_names);
xlabel('Model');
ylabel('Score');
ylim([0 1]);
legend('Mean Accuracy', 'F1 Score')
title('Comparison of Average Accuracy and F1 Score for Each Model');

