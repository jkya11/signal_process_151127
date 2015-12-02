

max_T = 10000;

T = 20;
t = 1:1:max_T;
sig = (square(2*pi*t/T)+1) / 2;


[b,a] = cheby1(6,10,0.6);


yfilt = conv(sig, b, 'same');

plot(yfilt);