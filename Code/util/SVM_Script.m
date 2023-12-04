% Unused SVM script
% Support Vector Machine (SVM)
% Assuming X and y are your data and labels respectively
k = 10; % Number of folds
cv = cvpartition(size(X, 1), 'KFold', k);

SVMtotalConfMat = zeros(2, 2); % Initialize confusion matrix, adjust size if more than 2 classes
totalAccuracy = 0;
totalF1Score = 0;

for i = 1:k
    % Split data into training and test sets for the current fold
    idx = test(cv, i);
    XTrain = X(~idx, :);
    YTrain = y(~idx);
    XTest = X(idx, :);
    YTest = y(idx);

    % Train SVM model
    SVMModel = fitcsvm(XTrain, YTrain, 'KernelFunction', 'linear', 'BoxConstraint', 1);

    % Predict labels for the test set
    YPred = predict(SVMModel, XTest);

    % Update the confusion matrix for this fold
    foldConfMat = confusionmat(YTest, YPred);
    SVMtotalConfMat = SVMtotalConfMat + foldConfMat;

    % Evaluate the model for this fold
    accuracy = sum(YPred == YTest) / numel(YTest);
    totalAccuracy = totalAccuracy + accuracy;

    % Calculate TP, FP, FN for the F1 score
    TP = sum((YPred == 1) & (YTest == 1));
    FP = sum((YPred == 1) & (YTest == 0));
    FN = sum((YPred == 0) & (YTest == 1));

    % Calculate precision and recall
    precision = TP / (TP + FP);
    recall = TP / (TP + FN);

    % Calculate F1 score for this fold
    if (precision + recall) == 0
        f1Score = 0;
    else
        f1Score = 2 * (precision * recall) / (precision + recall);
    end
    totalF1Score = totalF1Score + f1Score;
end

% Average accuracy and F1 score across all folds
SVMaccuracy = totalAccuracy / k;
SVMf1Score = totalF1Score / k;