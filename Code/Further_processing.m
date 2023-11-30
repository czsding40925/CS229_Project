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
