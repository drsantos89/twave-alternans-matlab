function [beat_vector_corr, b] = beat_correlation_fun(signal, spikes, beat_vector_corr, beat_median_odd, beat_median_even, Fs)
    % Calculates beat correlation
    
    b = zeros(length(spikes), size(signal,2));
    for i = 1:size(beat_vector_corr,2)
        for j = 1:size(beat_vector_corr,3)
            if mod(i,2) == 1 %if i is odd
                beat_corr = corr2(beat_vector_corr(:,i,j), beat_median_odd(:,j));
                if beat_corr < 0.95
                    beat_vector_corr(:,i,j) = beat_median_odd(:,j);
                    b(i,j) = 1;
                end
            else %if i is even
                beat_corr = corr2(beat_vector_corr(:,i,j), beat_median_even(:,j));
                if beat_corr < 0.95
                    beat_vector_corr(:,i,j) = beat_median_even(:,j);
                    b(i,j) = 1;
                end
            end
        end
    end

end

