
function y = SchroederVerb(x, earlyGain, lateGain, fs)
% SYNTAX
%
% y = SchroederVerb(x, earlyGain, lateGain, fs) 
%
% DESCRIPTION
%
% y = SchroederVerb(x, earlyGain, lateGain, fs) applies a reverb algorithm
% to the signal 'x'. 'earlyGain' is the gain applied to early relections
% and 'lategain' is the gain apllied to late reflections these values 
% should be less than 1. 'fs' is the sample rate.
%
% The vectors 'earlyDelayLen' and 'lateDelayLen' specify the time in
% seconds of early and late reflections. the signal 'x' is passed in series
% through allpass filters this leaves all frequencies at a flat magnitude but 
% changes the phase relationship of frequencies for the early reflections.
% The signal is then passed in parrallel through comb filters, this
% combines the signal 'y' with a delayed version of itself
% causing phase interferance, changing the spectral image of late reflections.
%                                                                           
% EXAMPLE
%
% % Apply SchroederVerb to the audio sample test.wav
% 
% [x, fs] = audioread('test.wav')                   read audio file
% earlyGain = 0.5;                                  assign gain for early reflection 
% lateGain = 0.2;                                   assign gain for late reflection
%
% y = SchroederVerb(x, earlyGain, lateGain, fs);    run function    
% 
% sound(y,fs);                                      Listen to audio with reverb applied.

earlyDelayLen = [0.005, 0.002, 0.001]; %early delay time in seconds
lateDelayLen = [0.1, 0.09, 0.08, 0.095]; %late time in seconds
% allpass phase:
y = allpass(x, fs, earlyGain, earlyDelayLen(1)); 
y = allpass(y, fs, earlyGain, earlyDelayLen(2)); 
y = allpass(y, fs, earlyGain, earlyDelayLen(3));
% comb-filter phase:
y1 = comb(y, fs, lateGain, lateDelayLen(1)); 
y2 = comb(y, fs, lateGain, lateDelayLen(2)); 
y3 = comb(y, fs, lateGain, lateDelayLen(3)); 
y4 = comb(y, fs, lateGain, lateDelayLen(4));
% mix filtered signals back together and normalise...
y = y1+y2+y3+y4;
y= y./max(y);
end