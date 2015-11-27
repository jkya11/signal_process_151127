function [ th ] = get_th(processed_window_size, looking_window_size, moving_flag, signal, down_sampling_rate)

    avg = zeros(1, processed_window_size);
    sum = 0;
    count = 0;
    
    for i = 1+moving_flag*looking_window_size:looking_window_size+moving_flag*looking_window_size
        sum = sum + signal(i);
        if mod(i,down_sampling_rate) == 0
            count = count + 1;
            avg(1, count) = sum / down_sampling_rate;
            sum = 0;
        end
    end

    sorted_avg = sort(avg);
    min_5_avg = sorted_avg(1:5);
    max_5_avg = sorted_avg(end-4:end);

    th = (mean(min_5_avg) + mean(max_5_avg)) / 2;