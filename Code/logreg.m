% Set up for cross-validation
k = 10;  % Number of folds
cv = cvpartition(length(y), 'KFold', k);
accuracy = zeros(1, cv.NumTestSets);

% Logistic regression with k-fold cross-validation
for i = 1:cv.NumTestSets
    trainingIdx = cv.training(i);
    testIdx = cv.test(i);
    
    % Train logistic regression model for this fold
    glm = fitglm(rateChange(trainingIdx), y(trainingIdx), 'Distribution', 'binomial', 'Link', 'logit');
    
    % Predict on test set for this fold
    yPred = predict(glm, rateChange(testIdx));
    yPredBinary = yPred > 0.5;  % Convert predicted probabilities to binary values
    
    % Compute accuracy for this fold
    accuracy(i) = sum(yPredBinary == y(testIdx)) / length(y(testIdx));
end

% Compute average accuracy across all folds
meanAccuracy = mean(accuracy);
fprintf('Mean accuracy across %d folds: %.2f%%\n', k, meanAccuracy*100);

% Visualization
figure;

% 1. Plot the Data Points
scatter(rateChange, zeros(size(rateChange)), 40, y, 'filled');
colormap('jet'); 

% 2. Plot the Decision Boundary
rateChange_values = linspace(min(rateChange), max(rateChange), 1000);
probabilities = predict(glm, rateChange_values(:));
[~, idx] = min(abs(probabilities - 0.5));
decision_boundary = rateChange_values(idx);
line([decision_boundary decision_boundary], [-0.1 1.1], 'Color', 'k', 'LineStyle', '--');

% 3. Plot the Logistic Regression Curve
hold on;
plot(rateChange_values, probabilities, 'g-', 'LineWidth', 2);

% 4. Adjust the Plot
xlabel('Change in Firing Rate (rateChange)');
ylabel('Probability');
title('Logistic Regression with Decision Boundary');
legend('Data Points', 'Decision Boundary', 'Logistic Regression Curve');
axis([min(rateChange) max(rateChange) -0.1 1.1]);
