function [tw_vector] = twave_vector(signal, spikes, beat_vector_corr, tw_low_wind, tw_length)
% Creates a matrix of extracted t-waves
tw_vector = nan(tw_length,length(spikes),size(signal,2));
    
for i = 1:length(spikes)
    for j = 1:size(signal,2)
        tw_vector(:,i,j) = beat_vector_corr(...
            tw_low_wind : tw_low_wind+tw_length-1,i,j);
    end
end

end

