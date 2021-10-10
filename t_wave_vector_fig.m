function t_wave_vector_fig(t_wave_vector)

    num_signals = size(t_wave_vector,3);

    figure('Position',get(0,'ScreenSize'));
    hold on;
    
    for i = 1:num_signals
        plot(t_wave_vector(:,:,i));
        refline(0,0)
    end

end

