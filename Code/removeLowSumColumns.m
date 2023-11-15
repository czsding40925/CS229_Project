function outputMatrix = removeLowSumColumns(inputMatrix)
    % Calculate the sum of each column
    colSum = sum(inputMatrix);
    
    % Find indices of columns with sum >=5 % try: change to 5, 10, 20, etc
    colsToKeep = colSum >= 10;
    
    % Keep only the columns with sum >= 2
    outputMatrix = inputMatrix(:, colsToKeep);
end
