% Assuming 'X' is your feature matrix and 'y' is the corresponding label vector
load("data_main.mat")
X = data_main(:, 1:96);
y = data_main(:, 97);
X = removeLowSumColumns(X);

% Split the data into a training set and a test set
cv = cvpartition(size(X, 1), 'HoldOut', 0.1); %change 
idx = cv.test;
XTrain = X(~idx, :);
YTrain = y(~idx);
XTest = X(idx, :);
YTest = y(idx);

% Fit GDA model
gdaModel = fitcdiscr(XTrain, YTrain, 'DiscrimType', 'linear');

% If your data is not linearly separable, you might want to try 'quadratic' DiscrimType
% gdaModel = fitcdiscr(XTrain, YTrain, 'DiscrimType', 'quadratic');

% Predict labels for the test set
YPred = predict(gdaModel, XTest);

% Evaluate the model
accuracy = sum(YPred == YTest) / numel(YTest);
disp(['Accuracy: ', num2str(accuracy)]);