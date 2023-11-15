% X - features, y - target variable
load("data_main.mat")
X = data_main(:, 1:96);
y = data_main(:, 97);
X = removeLowSumColumns(X);
noiseStd = 1e-6;  % This is a very small noise level

% Add Gaussian noise to each element of X
X_noisy = X + noiseStd * randn(size(X));

% Filter out columns with zero variance
% X_filtered = X(:, nonZeroVarianceIndices);
% Train Naive Bayes classifier
% distributionNames = repmat({'mn'}, 1, size(X, 2));
% distributionNames{58} = 'mvmn';  % Change 'mvmn' to 'bernoulli' if the feature is binary

% nbModel = fitcnb(X, y);
nbModel = fitcnb(X_noisy, y);

% Perform 10-fold cross-validation
CVMdl = crossval(nbModel, 'KFold', 10);

% Evaluate the cross-validated model's loss
kfoldLoss = kfoldLoss(CVMdl);
disp(['10-fold cross-validated loss: ', num2str(kfoldLoss)]);

% To get the classification accuracy instead, you could compute:
kfoldAccuracy = 1 - kfoldLoss;
disp(['10-fold cross-validated accuracy: ', num2str(kfoldAccuracy)]);
