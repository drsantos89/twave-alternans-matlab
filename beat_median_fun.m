function [beat_median_corr, beat_median_odd_corr, beat_median_even_corr] = beat_median_corr(beat_vector_corr)

beat_median_corr = nanmedian(beat_vector_corr(:,:,:),2);
beat_median_odd_corr = nanmedian(beat_vector_corr(:,1:2:end,:),2);
beat_median_even_corr = nanmedian(beat_vector_corr(:,2:2:end,:),2);

beat_median_corr = reshape(beat_median_corr,[size(beat_median_corr,1) size(beat_median_corr,3)]);
beat_median_odd_corr = reshape(beat_median_odd_corr,[size(beat_median_odd_corr,1) size(beat_median_odd_corr,3)]);
beat_median_even_corr = reshape(beat_median_even_corr,[size(beat_median_even_corr,1) size(beat_median_even_corr,3)]);

end

