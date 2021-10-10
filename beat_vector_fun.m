function [beat_vector, beat_median, beat_median_odd, beat_median_even] = beat_vector(signal, qrs, Fs)

for i = 1:length(qrs)
    for j = 1:size(signal,2)
        if qrs(i)+0.4*Fs < size(signal,1)
            beat_vector(:,i,j) = signal(qrs(i)-0.1*Fs:qrs(i)+0.4*Fs,j);
        end
    end
end

beat_median = nanmedian(beat_vector(:,:,:),2);
beat_median_odd = nanmedian(beat_vector(:,1:2:end,:),2);
beat_median_even = nanmedian(beat_vector(:,2:2:end,:),2);

beat_median = reshape(beat_median,[size(beat_median,1) size(beat_median,3)]);
beat_median_odd = reshape(beat_median_odd,[size(beat_median_odd,1) size(beat_median_odd,3)]);
beat_median_even = reshape(beat_median_even,[size(beat_median_even,1) size(beat_median_even,3)]);
end

