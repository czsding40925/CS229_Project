function transformedData = transformNeuronData(data)
    % Transforming an n*2 matrix to an m*k matrix as described

    % Validate input
    if size(data, 2) ~= 2
        error('Data matrix must have two columns: first for neuron IDs and second for firing times.');
    end

    % Determining the range of neuron IDs and time points
    maxNeuronID = max(data(:, 1));
    maxTime = max(data(:, 2));

    % Initializing the new matrix
    transformedData = zeros(maxTime, maxNeuronID);

    % Populating the new matrix
    %for i = 1:size(data, 1)
        %neuronID = data(i, 1);
        %timePoint = data(i, 2);
        %transformedData(timePoint, neuronID) = 1;  % Assuming '1' indicates a firing event
    %end
end
