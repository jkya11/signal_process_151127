clear all
close all

% define varibles
number_of_samples = 10000;
gaussian_sigma = 1;

down_sampling_rate = 10;
looking_window_size = 100;
% process_window_size = 1000;
moving_flag = 0;

processed_window_size = number_of_samples / down_sampling_rate;
last_pos_of_flag = number_of_samples / processed_window_size;

% signal generation
signal = signal_generate(number_of_samples, gaussian_sigma);

% print signal
figure_num = 1;
print_signal(signal, number_of_samples, figure_num);

out_signal = zeros(1, processed_window_size);

while moving_flag < last_pos_of_flag
    th = get_th(processed_window_size, looking_window_size, moving_flag, signal, down_sampling_rate);
    out_signal = get_outsignal(signal, processed_window_size, moving_flag, down_sampling_rate, th, out_signal);
    moving_flag = moving_flag + 1;
end

% print out_signal
figure(2);
x_range = 1:processed_window_size;
plot(x_range, out_signal, 'r'); hold on;
plot(x_range, out_signal, 'o');
