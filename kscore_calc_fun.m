function [k_score] = k_score_calc_fun(tw_vector, raw, filter, dodetrend)
% Calculates the TWA based on the spectral method (K-score)

  
tw_magnitudes = tw_vector(:,1:size(tw_vector,2))';
tw_magnitudes(isnan(tw_magnitudes)) = 0;
if dodetrend == 2
    temp = detrend(tw_magnitudes,'constant');
elseif dodetrend ==1
    temp = diff(tw_magnitudes);
end

F = [0:size(temp,1)-1]/size(temp,1);
F = interp1([0:size(temp,1)-1]', F, ...
    [0:size(temp,1)/512:size(temp,1)-1]');
%F = [0:size(temp,1)-1]/size(temp,1)*(1/(size(tw_magnitudes,1)/512));
k_score.tw_band = find(F>.495&F<=.5);
%[~, kscore.tw_band] = min(abs(F-0.5));
k_score.noise_band = find(F>.43&F<.46);
    
pw_fft = mean(abs(fft(temp)).^2,2);
pw_fft = interp1([0:size(temp,1)-1]',pw_fft, ...
    [0:size(temp,1)/512:size(temp,1)-1]');

k_score.twa_pw = mean(pw_fft(k_score.tw_band));
k_score.twa_mean_noise = mean(pw_fft(k_score.noise_band));
k_score.twa_std_noise = std(pw_fft(k_score.noise_band));
k_score.twa_voltage = real(sqrt(k_score.twa_pw - k_score.twa_mean_noise));
k_score.k_score = (k_score.twa_pw - k_score.twa_mean_noise) / ...
    k_score.twa_std_noise;    
end