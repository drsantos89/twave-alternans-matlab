function beat_vector_fig(beat_vector, beat_median, beat_median_odd, beat_median_even)

    num_signals = size(beat_vector,3);

    figure('Position',get(0,'ScreenSize'));
    hold on;
    
    for i = 1:num_signals
        subplot(num_signals,4,1+((i-1)*4));
        plot(beat_vector(:,:,i));
        refline(0,0)
        subplot(num_signals,4,2+((i-1)*4));
        plot(beat_median(:,i));
        refline(0,0)
        subplot(num_signals,4,3+((i-1)*4));
        plot(beat_median_odd(:,i));
        refline(0,0)
        subplot(num_signals,4,4+((i-1)*4));
        plot(beat_median_even(:,i));
        refline(0,0)
    end

end

