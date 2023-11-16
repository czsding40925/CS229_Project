% Assuming dataMatrix is your 100x97 matrix
load("data_main.mat")
X = data_main(:, 1:96); % Predictors
y = data_main(:, 97);   % Response
X = removeLowSumColumns(X);

% Setting up 10-fold cross-validation
c = cvpartition(y, 'KFold', 10);

% Initialize vector to store results
accuracy = zeros(c.NumTestSets, 1);

% Perform logistic regression for each fold
for i = 1:c.NumTestSets
    % Training data for this fold
    trainX = X(training(c, i), :);
    trainY = y(training(c, i));

    % Test data for this fold
    testX = X(test(c, i), :);
    testY = y(test(c, i));

    % Fit logistic regression model
    model = fitglm(trainX, trainY, 'Distribution', 'binomial');

    % Predict on test data
    predictions = predict(model, testX) > 0.5; % Using 0.5 as threshold

    % Calculate accuracy
    accuracy(i) = mean(predictions == testY);
end

% Overall performance
meanAccuracy = mean(accuracy);
disp(['Mean Accuracy: ', num2str(meanAccuracy)]);
