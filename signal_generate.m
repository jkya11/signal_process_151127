function [ yfilt ] = signal_generate( max_T, sigma )
% generate rect signal

T = 20;
t = 1:1:max_T;

sig = (square(2*pi*t/T)+1) / 2;

size = max_T;
x = linspace(-size / 2, size / 2, size);
gaussFilter = exp(-x.^2 / (2 * sigma ^ 2));
gaussFilter = gaussFilter / sum(gaussFilter);

% yfilt = filter(gaussFilter, 1, sig);
yfilt = conv(sig, gaussFilter, 'same');


end

