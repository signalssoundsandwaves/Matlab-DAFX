function y = tap_delay(x, nTaps, delayt, gain, decay, fs) 
% SYNTAX
%
% y = tap_delay(x, nTaps, delayt, gain, decay, fs)
%
% DESCRIPTION
%
% y = tap_delay(x, nTaps, delayt, gain, decay, fs) applies a tap delay to
% the signal 'x'. Where 'nTaps' specifies the number of delays of the signal, 
% 'delayt' specifies the delay time in seconds, 'gain' is the gain of the delayed signal
% 'decay' is how much the delay exponentially decays by this should be below 1.
% 'fs' is the sampleing frequency.
%
% A prelimenary vector for 'y' is assigned with zeros appended to extend
% the length to include the delay time in samples, 'nsamples'. A for loop 
% is used to create a delay line,'newDelayLine', zeros are appended before 
% and after a duplicate of the signal. The signals 'y' and 'newDelayLine' 
% are mixed.
%
% EXAMPLE
%
% Apply delay to the audio sample test.wav
% 
% [x, fs] = audioread('test.wav')   read audio file
% nTaps = 2;                        assign a 2 tap delay; 
% delayt = 0.6;                     assign a delay time in secs
% gain = 0.8                        set a value for gain between 0-1;
% decay = 0.6                       set a value for the exponential decay between 0 - 1;
% y = tap_ delay(x, moda, modf, fs);    run function    
% 
% sound(y,fs);                      listen back to audio with effect

nSamples = round(delayt*fs);

y = [x, zeros(1,nTaps*nSamples)]*gain; 

for tapNo = 1:nTaps
    
    newDelayLine = [zeros(1,nSamples*tapNo),x,... 
        zeros(1,(nSamples*nTaps)-(nSamples*tapNo))];
    
    gain = gain*decay;
y = y + newDelayLine*gain;
end

end