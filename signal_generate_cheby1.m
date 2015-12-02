function [ yfilt ] = signal_generate_cheby1( max_T, cheby_n )
% generate rect signal

    T = 20;
    t = 1:1:max_T;
    sig = (square(2*pi*t/T)+1) / 2;

    [b,a] = cheby1(cheby_n,10,0.6);

    yfilt = conv(sig, b, 'same');

end

