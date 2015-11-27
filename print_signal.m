function print_signal(signal, number_of_samples, figure_num)

figure(figure_num)
stem(signal);
axis([0 number_of_samples -0.5 1.5]);
xlabel('Time');
ylabel('Amplitude');
title('Square Periodic Wave');