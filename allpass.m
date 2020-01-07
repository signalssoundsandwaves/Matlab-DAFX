function y = allpass(x, fs, gain, delayLen) % note, gain should be less than 1. 
delayLen = round(delayLen*fs);
% create coefficients
b = [gain, zeros(1, delayLen-1), 1];
a = [1, zeros(1, delayLen-1), gain]; 
% filter the input signal
y = filter(b,a,x);
