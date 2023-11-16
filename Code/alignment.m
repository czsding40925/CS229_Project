% Main Data processing script 
% align this with cues 
% Neural data and lever position data 
% End goal for each trial 
    % x_1, ..., x_d be neuron firing rate (d varies based on the date)
    % p = lever position (average?), which can be a predictor for learning
directories = {'2023_09_12', '2023_09_14', '2023_09_15'};
for i=1:length(directories)
    cd("Data/sch13/"+directories{i})
    load("Behavior_Camera_Stim_Struct.mat")
    load("tagged_unit_ids.mat")
    cueTimes = beh_cam_stim.GoStamps;
    % Constants
    samplingRate = 30000;  % 30kHz sampling rate
    preCueWindow = 1.5 * samplingRate;  % 1 second before cue, converted to samples
    postCueWindow = 2.5 * samplingRate;  % 1.5 seconds after cue, converted to samples
    
    % the cue windows might be a little bit arbitrary...
    % this data gives u the which neuron(channel) fired at what time. 
    data = [channelID spikeTimes];
    % Only consider the corticol_good neuron
    isNeuronOfInterest = ismember(data(:, 1), cortical_good);
    filteredData = data(isNeuronOfInterest, :);
    % Create a n*2 matrix (n=100, number of cues) of cue windows 
    
    cue_windows = zeros(length(cueTimes),2);
    for i = 1:length(cueTimes)
        this_cueTime = cueTimes(i);
        cue_windows(i,:) = [cueTimes(i)-preCueWindow cueTimes(i)+postCueWindow];
    end 
    
    lever_position = beh_cam_stim.LeverPosition;
    % Try: intiating a cell 
    lever_position_per_cue = cell(length(cueTimes),1);
    neural_spikes_per_cue = cell(length(cueTimes),1);
    for i=1:length(cueTimes)
        current_indices = lever_position(:,1) >= cue_windows(i,1) & lever_position(:,1) <= cue_windows(i,2);
        current_indices_ns = filteredData(:,2) >= cue_windows(i,1) & filteredData(:,2) <= cue_windows(i,2);
        lever_position_per_cue{i} = lever_position(current_indices, 2);  
        neural_spikes_per_cue{i} = filteredData(current_indices_ns,1);
    end 
    
    aligned_data = [lever_position_per_cue, neural_spikes_per_cue];
    save("aligned_data.mat",'aligned_data')
    
    % further processing 
    % Goal: get things out put a binary y label based on the lever position
    % aligned with cue 
    y_label = zeros(length(cueTimes),1);
    for i = 1:length(y_label)
        cellContent = aligned_data{i, 1};
        
        if length(cellContent) <= 5
            y_label(i) = 0;
        else
            y_label(i) = 1;
        end
    end
    
    % Extract the content in the second column of the aligned data 
    X = zeros(length(cueTimes), length(cortical_good));
    for i=1:length(cueTimes)
        % extract neural data for each cell 
        current_neural_data = aligned_data{i,2};
        for j=1:length(cortical_good)
            X(i,j) = sum(current_neural_data==cortical_good(j));
        end
    end 
    
    % output data 
    data_main = [X y_label];
    save("data_main.mat",'data_main')
    writematrix(data_main,"data_main.csv")
    cd("..")
    cd("..")
    cd("..")
end 


