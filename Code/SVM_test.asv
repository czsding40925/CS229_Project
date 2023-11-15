% Load your dataset
load("data_main.mat")
X = data_main(:, 1:96);
y = data_main(:, 97);
X = removeLowSumColumns(X);

% Split data into training and testing sets (here, we use 90% for training and 10% for testing)
cv = cvpartition(size(X, 1), 'HoldOut', 0.1);
idx = cv.test;
XTrain = X(~idx, :);
YTrain = y(~idx, :);
XTest = X(idx, :);
YTest = y(idx, :);

% Train an SVM model. Here, we use a linear kernel, but you can try others like 'rbf'
SVMModel = fitcsvm(XTrain, YTrain, 'KernelFunction', 'linear', 'BoxConstraint', 1);

% Make predictions on the test set
YPred = predict(SVMModel, XTest);

% Evaluate the model
accuracy = sum(YPred == YTest) / numel(YTest);
disp(['Accuracy: ', num2str(accuracy)]);
