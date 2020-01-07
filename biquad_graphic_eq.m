function y = biquad_graphic_eq(x, gain1, gain2, gain3, gain4, gain5, fs)
%SYNTAX
% 
% y = biquad_graphic_eq(x, gain1, gain2, gain3, gain4, gain5, fs)
% 
% DESCRIPTION
%
% y = biquad_graphic_eq(x, gain1, gain2, gain3, gain4, gain5, fs) applies a
% Biquad Graphic EQ to the signal 'x'. The respective variables 'gain2'-'gain4'
% control the amplification and attenuation of bandpass filters in dB, 'gain1'
% and 'gain5' are shelving filters. 'fs' is the sample rate. 
%
% Central frequencies are specified by 'fc1' - 'fc5'.'Q' controls the bandwidth 
% of the filters.
%
% The signal 'x' is passed in parallel through the filters and summed at
% their output ('y').
% 
%EXAMPLE
%
%Apply equalisation to an the audio sample test.wav
% 
% [x, fs] = audioread('test.wav')   read audio file
% gain1 = 0.8;                      assign amplitude for low Shelf 
% gain2 = ;                         assign frequency for modulation
%  
% y = ampmod(x, moda, modf, fs);    run function    
% 
% sound(y,fs);

 if nargin <=6
     fs = 44100;
 end
Q = 10;
fc1 = 500;
fc2 = 1000;
fc3 = 2500;
fc4 = 5000;
fc5 = 10000;

y1 = LSBiquad(x,fc1,gain1,Q,fs);
y2 = PBiquad(x,fc2,gain2,Q,fs);
y3 = PBiquad(x,fc3,gain3,Q,fs);
y4 = PBiquad(x, fc4, gain4, Q,fs);
y5 = HSBiquad(x, fc5, gain5,Q, fs);

y = y1 + y2 + y3 + y4 + y5;

end
