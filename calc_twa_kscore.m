function calc_t_wave_alternans_k_score_method(signal, plot_figs=true)
% this function calculates T-wave alternans (TWA) magnitude based on the
% spectral method (K-score)

%%% detect beats
[signal_raw,Fs,tm] = rdsamp(signal)

%%% Beat detection
gqrs(signal);
qrs = rdann(signal,'qrs');

%%% build beat vector
[beat_vector] = beat_vector_fun(signal_raw, qrs, Fs);

%%% correct baseline
beat_vector_corr = baseline_correction_fun(signal_raw_no_spikes, spikes, Fs, CL, beat_vector, method);
baseline_correction_fig(beat_vector, beat_vector_corr, protocol, raw, filter, correlation, method, channels, name)

%%% calculate median beats
[beat_median, beat_median_odd, beat_median_even] = beat_median_fun(beat_vector_corr);

%%% replace low correlation beats
beat_vector_corr_temp = beat_vector_corr;
[beat_vector_corr, b] = beat_correlation_fun(signal_raw_no_spikes, spikes, beat_vector_corr, beat_median_odd, beat_median_even, Fs);
beat_correlation_fig(beat_vector_corr, beat_vector_corr_temp, beat_median_odd, beat_median_even, b, protocol, raw, filter, correlation, method, channels, name)

for j = 1:size(signal_raw_no_spikes,2)
    precentage_abnormal_beat(p,j) = sum(b(:,j))/length(spikes)*100;
end

%%% build t_wave vector
[tw_vector] = t_wave_vector_fun(signal_raw_no_spikes, spikes, beat_vector_corr, tw_low_wind, tw_length);

%%% calculate K-score
tw_vector = tw_vector./repmat(sqrt(nanmean(tw_vector(:,:,:).^2)),[size(tw_vector,1),1]);
[k_score] = kscore_calc_fun(channels, tw_vector, protocol, raw, filter, correlation, method, name, dodetrend);

end