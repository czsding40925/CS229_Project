% Further Data Processing
% Calculate mean accuracy/F1 score 
data_summaries = {'data_summary_09_12.mat','data_summary_09_14.mat','data_summary_09_15.mat'};
F1_scores = zeros(5,3);
Mean_accuracy = zeros(5,3);

for i = 1:3
    this_data = load(data_summaries{i});
    
    % Get the field names of the loaded data
    data_fieldnames = fieldnames(this_data);
    
    % Assuming there's only one field per loaded file
    if length(data_fieldnames) == 1
        struct_name = data_fieldnames{1};
        
        % Access the fields from the struct
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

% Working with Confusion Matrices
CF_0912 = load('CF_0912.mat').CF_0912;
CF_0914 = load('CF_0914.mat').CF_0914;
CF_0915 = load('CF_0915.mat').CF_0915;

% Create a large figure
figure('Name', 'Confusion Matrices', 'NumberTitle', 'off', 'Position', [100, 100, 1500, 900]);

datasets = {'09/12', '09/14', '09/15'};
models = fieldnames(CF_0912);
allCFs = {CF_0912, CF_0914, CF_0915};

% Index for subplot
subplotIdx = 1;

for i = 1:length(datasets)
    for j = 1:length(models)
        % Select a subplot position
        subplot(3, 5, subplotIdx);
        subplotIdx = subplotIdx + 1;

        % Get the confusion matrix
        CM = allCFs{i}.(models{j});

        % Plot the confusion matrix
        heatmap(CM);
        title([models{j}, ' - ', datasets{i}]);

        % Optional: Customize the plot, e.g., set axis labels
        xlabel('Predicted Class');
        ylabel('True Class');
    end
end

% Optional: Adjust layout
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0, 1, 1]);

