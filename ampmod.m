function y = ampmod(x, moda, modf, fs)
% SYNTAX
%
% y = ampmod(x, moda, modf, fs)
%
% DESCRIPTION
%
% y = ampmod(x, moda, modf, fs) applies ampltitude modulation to the signal
% 'x'. The value of 'moda' is the amplitude of modulation and should be a 
% value less than 1. The value of 'modf' is the frequency of modulation and 
% should be no greater than half the sampleing frequency, refered to by 'fs'.
%
% A sine wave 'mod' is created at the length of the input signal 'x', this is 
% used to modulate the amplitude of 'x' returning the processed signal, 'y'.
%
% EXAMPLE
%
% Apply amplitude modulation to the audio sample test.wav
% 
% [x, fs] = audioread('test.wav')   read audio file
% moda = 0.8;                       assign amplitude for modulation 
% modf = 20;                        assign frequency for modulation
%  
% y = ampmod(x, moda, modf, fs);    run function    
% 
% sound(y,fs);                      listen back to audio with effect

if nargin<=5
    fs = 44100;
end

dur = length(x)/fs;

ts= 1/fs;
t = ts:ts:dur;

mod = moda .* sin(2*pi*modf*t);
y = mod .* x;
end
