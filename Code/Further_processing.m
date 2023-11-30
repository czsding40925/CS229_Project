% Further Data Processing
% Calculate mean accuracy/F1 score 
data_summaries = {'data_summary_09_12.mat','data_summary_09_14.mat','data_summary_09_15.mat'};
F1_scores = zeros(5,3);
Mean_accuracy = zeros(5,3);
for i = 1:3
    this_data = load(data_summaries{i});
    F1_scores(:,i) = this_data.F1;
    Mean_accuracy = this_data.Accuracy;
end 
