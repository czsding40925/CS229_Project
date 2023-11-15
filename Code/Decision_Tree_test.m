% Load your dataset here
load("data_main.mat")
X = data_main(:, 1:96);
y = data_main(:, 97);
X = removeLowSumColumns(X);

% Create a default decision tree template
t = templateTree('MaxNumSplits', 1); % Use decision stumps

% Train the AdaBoostM1 model with decision trees as weak learners
boostedMdl = fitcensemble(X, y, ...
                          'Method', 'AdaBoostM1', ...
                          'Learners', t, ...
                          'NumLearningCycles', 40, ... % Number of boosting iterations
                          'LearnRate', 0.08, ... % Learning rate
                          'CrossVal', 'on', ... % Turn on cross-validation
                          'KFold', 10); % 10-fold cross-validation

% Evaluate the cross-validated loss
cvLoss = kfoldLoss(boostedMdl);

% Display the loss
disp(['10-fold cross-validated loss: ', num2str(cvLoss)]);

% Calculate and display the cross-validated accuracy
predictedLabels = kfoldPredict(boostedMdl);
accuracy = sum(predictedLabels == y) / numel(y);
disp(['10-fold cross-validated accuracy: ', num2str(accuracy)]);
