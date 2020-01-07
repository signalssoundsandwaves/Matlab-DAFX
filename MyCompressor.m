
function y = MyCompressor(x, T, R, k, fs)
% SYNTAX
%
% y = MyCompressor(x, T, R, k, fs)
%
% DESCRIPTION
% 
% y = MyCompressor(x, T, R, k, fs) applies compression to the signal 'x' 
% the value 'T' is the threshold given in dB's which should be a negative 
% value. 'R' is the ratio of compression which should be greater than 1 for
% compression to take affect.'k' is the knee of the compressor a value of
% 10 gives a soft curve into compression. 'fs' is the sample rate.
%
% Using a for loop the RMS in dB's is computed from frames of the signal 'x' 
% (frame) creating an amplitude envelope (dbenv). A transfer function is then 
% applied to the envelope specified by 'T', 'R' and 'k'. The returned array 
% (dbGain) is converted back to linear gain and multipled by the orignal 
% frames of 'x' (frame) applying gain reducton.
%
% EXAMPLE
% 
% Apply compression to the audio sample test.wav
% 
% [x, fs] = audioread('test.wav')      read audio file
% T = -10;                             assign Threshold 
% R = 4;                               assign Ratio
% k = 10;                              assign knee
%
% y = MyCompressor(x, T, R, k, fs);    run function    
% 
% sound(y,fs);                         Listen to compressed audio.

ts = 1/fs;
dur = length(x)/fs;
t = 0 :ts:dur-ts;
%create frame parameters...
frameLen = 256;
frStart = 1;
frEnd   = frameLen;

% add some zeros onto the end for this to work properly...
numFrames = floor(length(x)/frameLen);

y=x;
for i = 1:numFrames
   % Compute Gain...
   frame = x(frStart:frEnd);
   frameCtrs(i) = t(frStart+round(frEnd-frStart));
   ampXrms(i) = sqrt(mean(frame.^2)); %RMS Amplitude   
   dbenv(i) = 20.*log10(ampXrms(i));    
   dbGain(i) = transferFunction(dbenv(i), R, T, k);
   lingain(frStart:frEnd) = 10.^(dbenv(i)-dbGain(i))/20;
   y(frStart:frEnd) = frame.*lingain(frStart:frEnd);
      
   frStart = frStart+frameLen;
   frEnd = frEnd+frameLen;
end

%y = y./abs(max(y));

figure(1);
plot(t, x); hold on; grid on;
plot(frameCtrs, ampXrms, 'r', 'LineWidth', 2 )

figure(2);
plot(t, y);

