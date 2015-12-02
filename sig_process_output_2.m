close all

% for j = 1:3
    j = 1;
    % define varibles
    if j == 1
        num_samples_from_prev = 2;
    else
        num_samples_from_prev = num_remain_samples;
    end
    
    samples_from_prev = zeros(1, num_samples_from_prev);

    number_of_samples = 1024;
    gaussian_sigma = 3;
    cheby_n = 6;
    down_sampling_rate = 10;

    looking_window_size = 16;
    noise_power = -10; % noise_power has dBW unit
    moving_flag = 0;

%     max_n_samples_to_choose = 3;
%     min_n_samples_to_choose = 5;

    processed_signal_size = floor(number_of_samples / down_sampling_rate);

    out_signal = zeros(1, processed_signal_size);

    % signal generation
    % gaussian filter
    % input_signal = signal_generate(number_of_samples, gaussian_sigma);
    % chebishev filter
    input_signal = signal_generate_cheby1(number_of_samples, cheby_n);
    % gaussian_sigma);
    
    % signal noising
    gaussian_noise = wgn(1,number_of_samples,noise_power);
    input_signal = input_signal + gaussian_noise;
    input_signal = [samples_from_prev input_signal];

    num_remain_samples = mod((num_samples_from_prev + number_of_samples), down_sampling_rate);
    number_of_samples = number_of_samples + num_samples_from_prev - num_remain_samples;

    % send remainder signal to next loop
    remain_samples = input_signal(end-(num_remain_samples-1):end);
    input_signal = input_signal(1:end-(num_remain_samples));

    % print signal
    figure_num = 1;
    print_signal(input_signal, number_of_samples, figure_num);

    % main procedure --------------------------------------------
    for i=1:processed_signal_size
        % get threshold
        if mod(i, looking_window_size) == 1
            if (i-1)*down_sampling_rate+1 <= number_of_samples && i*down_sampling_rate+1+down_sampling_rate*looking_window_size <= number_of_samples
                th = mean(input_signal((i-1)*down_sampling_rate+1:(i-1)*down_sampling_rate+1+down_sampling_rate*looking_window_size));
            else
                th = mean(input_signal(end-(down_sampling_rate*looking_window_size-1):end));
                th
            end
        end

        % get out_signal
        if mean(input_signal(down_sampling_rate*(i-1)+1:down_sampling_rate*i)) >= th
            out_signal(i) = 1;
        else
            out_signal(i) = 0;
        end
    end

    %--------------------------------------------------------------

    % print out_signal
    figure(2);
    x_range = 1:processed_signal_size;
    plot(x_range, out_signal, 'r'); hold on;
    plot(x_range, out_signal, 'o');

    % print the accuracy
    answer_signal = zeros(1,processed_signal_size);

    for i=1:processed_signal_size
        if mod(floor(i),2) == 1
            answer_signal(i) = 1;
        end
    end

    number_of_correct_samples = 0;
    for i=1:processed_signal_size
        if out_signal(i) == answer_signal(i)
            number_of_correct_samples = number_of_correct_samples+1;
        end
    end

    whole_accuracy = (number_of_correct_samples / processed_signal_size)*100;
    whole_accuracy
% end
