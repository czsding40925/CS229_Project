% Lever position test 
lever_position = beh_cam_stim.LeverPosition;
lever_position(:,1) = lever_position(:,1);
offline_start = beh_cam_stim.OfflineStartStamps;
offline_end = beh_cam_stim.OfflineEndStamps; 
trial_start = [1, offline_end(1)+1, offline_end(2)+1, offline_end(3)+1, offline_end(4)+1, offline_end(5)+1];
trial_end = [offline_start(1)-1, offline_start(2)-1, offline_start(3)-1, offline_start(4)-1, offline_start(5)-1, offline_start(6)-1];

for i=2:6
    selected_rows_1 = lever_position(:,1)<=trial_end(i) & lever_position(:,1)>=trial_start(i);
    % Lever position for trial i
    lp_trial_i = lever_position(selected_rows_1,:);

    plot(lp_trial_i(:,1)/30000, lp_trial_i(:,2))
    hold on 
end 
