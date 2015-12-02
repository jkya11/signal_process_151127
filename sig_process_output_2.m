
close all

% define varibles

number_of_samples = 10000;
gaussian_sigma = 1;

down_sampling_rate = 10;
moving_window_size = number_of_samples/100; % fixed
looking_window_size = 50; % 
noise_power = -10; % noise_power has dBW unit
moving_flag = 0;

max_n_samples_to_choose = 3;
min_n_samples_to_choose = 5;

processed_signal_size = number_of_samples / down_sampling_rate;
last_pos_of_flag = number_of_samples / processed_signal_size;

out_signal = zeros(1, processed_signal_size);

% signal generation
input_signal = signal_generate(number_of_samples, gaussian_sigma);
gaussian_noise = wgn(1,number_of_samples,noise_power);
input_signal = input_signal + gaussian_noise;

% print signal
figure_num = 1;
print_signal(input_signal, number_of_samples, figure_num);



% main process
while moving_flag < last_pos_of_flag
    th = get_th(moving_window_size, looking_window_size, moving_flag, input_signal, down_sampling_rate, max_n_samples_to_choose, min_n_samples_to_choose);
    out_signal = get_outsignal(input_signal, processed_signal_size, moving_flag, down_sampling_rate, th, out_signal);
    moving_flag = moving_flag + 1;
end

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
