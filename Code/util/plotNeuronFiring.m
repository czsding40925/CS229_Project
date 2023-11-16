function plotNeuronFiring(data)
    % This function takes a matrix 'data' where the first column is the neuron ID 
    % and the second column is the firing time, and plots a scatter plot.

    % Check if the data has two columns
    if size(data, 2) ~= 2
        error('Data matrix must have two columns: first for neuron IDs and second for firing times.');
    end

    % Extracting neuron IDs and firing times
    neuronIDs = data(:, 1);
    firingTimes = data(:, 2);

    % Creating the scatter plot
    figure;
    scatter(firingTimes, neuronIDs, 'filled');
    xlabel('Time of Firing');
    ylabel('Neuron ID');
    title('Scatter Plot of Neuron Firing Times');
    grid on;
end
