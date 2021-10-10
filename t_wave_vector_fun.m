function [tw_vector] = t_wave_vector_fun(beat_vector_corr, tw_low_wind, tw_length)
% Creates a matrix of extracted t-waves
    tw_vector = nan(tw_length, ...
        size(beat_vector_corr,2), ...
        size(beat_vector_corr,3));
        
    for i = 1:size(beat_vector_corr,2)
        for j = 1:size(beat_vector_corr,3)
            tw_vector(:,i,j) = beat_vector_corr(...
                tw_low_wind : tw_low_wind+tw_length-1,i,j);
        end
    end

end

