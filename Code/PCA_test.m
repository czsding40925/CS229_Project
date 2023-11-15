% Assuming your main dataset is stored in 'data_main' (100x97 matrix)
X = data_main(:, 1:96); % Extracting features
y = data_main(:, 97);   % Behavioral response

% PCA on the Overall Dataset
[coeff, score, ~, ~, explained] = pca(X);
figure; % Create a new figure
scatter(score(:,1), score(:,2));
xlabel('Principal Component 1');
ylabel('Principal Component 2');
title('PCA - Overall Data');

% PCA for Data with Behavioral Response
X_response = X(y == 1, :); % Data with behavioral response
[coeff_resp, score_resp, ~, ~, explained_resp] = pca(X_response);
figure; % Create a new figure
scatter(score_resp(:,1), score_resp(:,2), 'r');
xlabel('Principal Component 1');
ylabel('Principal Component 2');
title('PCA - Data with Behavioral Response');

% PCA for Data without Behavioral Response
X_no_response = X(y == 0, :); % Data without behavioral response
[coeff_no_resp, score_no_resp, ~, ~, explained_no_resp] = pca(X_no_response);
figure; % Create a new figure
scatter(score_no_resp(:,1), score_no_resp(:,2), 'b');
xlabel('Principal Component 1');
ylabel('Principal Component 2');
title('PCA - Data without Behavioral Response');
