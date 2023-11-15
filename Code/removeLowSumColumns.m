function outputMatrix = removeLowSumColumns(inputMatrix)
    % Calculate the sum of each column
    colSum = sum(inputMatrix);
    
    % Find indices of columns with sum >= 2
    colsToKeep = colSum >= 5;
    
    % Keep only the columns with sum >= 2
    outputMatrix = inputMatrix(:, colsToKeep);
end
