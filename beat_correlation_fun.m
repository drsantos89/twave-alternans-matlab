function [beat_vector_corr, b] = beat_correlation_fun(signal, spikes, beat_vector_corr, beat_median_odd, beat_median_even, Fs)
% Calculates beat correlation

start = 20*Fs/1000;
if size(beat_vector_corr,1) < (400+20)*Fs/1000
    finish = size(beat_vector_corr,1) - 20*Fs/1000;
else
    finish = 400*Fs/1000;
end

b = zeros(length(spikes),size(signal,2));
for i = 1:length(spikes)
    for j = 1:size(signal,2)
        if mod(i,2) == 1 %if i is odd
            beat_corr = corr2(beat_vector_corr(start:finish,i,j),beat_median_odd(start:finish,j));
            if beat_corr < 0.95
                beat_vector_corr(:,i,j) = beat_median_odd(:,j);
                b(i,j) = 1;
            end
        else %if i is even
            beat_corr = corr2(beat_vector_corr(start:finish,i,j), beat_median_even(start:finish,j));
            if beat_corr < 0.95
                beat_vector_corr(:,i,j) = beat_median_even(:,j);
                b(i,j) = 1;
            end
        end
    end
end

end

