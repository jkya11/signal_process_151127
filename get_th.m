function [ th ] = get_th(moving_window_size, looking_window_size, moving_flag, signal, down_sampling_rate, max_n_samples_to_choose, min_n_samples_to_choose)

    avg = zeros(1, looking_window_size);
    count = 0;
    
    for i = 1+moving_flag*moving_window_size:1+moving_flag*moving_window_size+looking_window_size
        if mod(i,down_sampling_rate) == 1
            count = count + 1;
            avg(1, count) = mean(signal(i:i+10));
        end
    end
    
    sorted_avg = sort(avg);
    min_n_avg = sorted_avg(1:min_n_samples_to_choose);
    max_n_avg = sorted_avg(end-(max_n_samples_to_choose-1):end);

    th = (mean(min_n_avg) + mean(max_n_avg)) / 2;