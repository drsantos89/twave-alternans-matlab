function [k_score_results] = kscore_calc_fun(tw_vector, dodetrend)
for chan = 1:size(tw_vector,3)
   
    tw_magnitudes = tw_vector(:, 1:size(tw_vector,2), chan)';
    tw_magnitudes(isnan(tw_magnitudes)) = 0;
    if dodetrend == 2
        temp = detrend(tw_magnitudes,'constant');
    elseif dodetrend ==1
        temp = diff(tw_magnitudes);
    end
    
    F = [0:size(temp,1)-1]/size(temp,1);
    F = interp1([0:size(temp,1)-1]',F,...
        [0:size(temp,1)/512:size(temp,1)-1]');
    %F = [0:size(temp,1)-1]/size(temp,1)*(1/(size(tw_magnitudes,1)/512));
    kscore.tw_band = find(F>.495&F<=.5);
    %[~, kscore.tw_band] = min(abs(F-0.5));
    kscore.noise_band = find(F>.43&F<.46);
        
    pw_fft = mean(abs(fft(temp)).^2,2);
    pw_fft = interp1([0:size(temp,1)-1]',pw_fft,...
        [0:size(temp,1)/512:size(temp,1)-1]');
    
    kscore.twa_pw = mean(pw_fft(kscore.tw_band));
    kscore.twa_mean_noise = mean(pw_fft(kscore.noise_band));
    kscore.twa_std_noise = std(pw_fft(kscore.noise_band));
    kscore.twa_voltage = real(sqrt(kscore.twa_pw - kscore.twa_mean_noise));
    kscore.k_score = (kscore.twa_pw - kscore.twa_mean_noise)/kscore.twa_std_noise;
    
    figure('Position',get(0,'ScreenSize'))
    plot(F',pw_fft,'k')
    box(gca,'on');
    set(findobj(gca,'type','line'),'linew',2)
    set(gca,'FontSize',16,'FontWeight','bold','LineWidth',2);
    xlabel('Frequency (Cycles/Beat)')
    ylabel('Magnitude (uV^2)')
    xlim([0 0.5])
    title(['kscore_' chan])
    text(0.3, max(pw_fft)/4*3, ['K-score:' num2str(kscore.k_score)])
    text(0.3, max(pw_fft)/4*2, ['twa voltage:' num2str(kscore.twa_voltage)])
    
    k_score_results(chan) = kscore;
    
end

