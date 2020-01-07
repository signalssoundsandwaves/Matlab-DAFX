 function y = variableDelay(x, Modfreq, mix, fs)  
 % SYNTAX
 %
 % y = variableDelay(x, Modfreq, mix, fs)
 %
 % DESCRIPTION
 %
 % y = variableDelay(x, Modfreq, mix, fs) applys a variable delay to the signal
 % 'x' using a fractional delay line. 'Modfreq' is the frequency of modulation
 % defined in Hz. 'mix' controls the ratio of input/output this should be
 % between 0 - 1. 'fs' is the sample rate.
 % 
 % The width of the modulation and the delay time are defined in samples in 
 % the variables 'WIDTH' and 'DELAY'. The argument 'Modfreq' is normalised
 % to a value between 0 - 1 and stored in 'MODFREQ'. Memory is prelimenarily
 % allocated for 'DelayLine' and the output 'y'. 
 %
 % A for loop over the length of 'x' is used to create a modulator, 'MOD' which
 % is used to scale the width of modulation. The variable 'ZEIGER' is the
 % true fractional delay time in samples, the floor() function is used to round the
 % true delay time to an integer value in 'i'. 'i' is subtracted 
 % from the true delay time to get a fractional result 'frac'. 'Delayline'
 % is defined concatinating the current index of x with the delay line and 
 % interpolation is used to smoothly modulate the delay.
 %
 % A 'mix' argument is added to control the desired amount of input/output.
 %
 % EXAMPLE
 %
 % Apply variable delay to the audio sample test.wav
 %
 % [x, fs] = audioread('test.wav')                  read audio file
 % Modfreq = 2;                                     assign modulation freq 
 % mix = 0.2;                                       assign mix value (0-1)
 % y = variableDelay(x, Modfreq, mix, fs)           run function    
 % 
 % sound(y,fs);                                     Listen to audio with effect

Width = 0.010; 
Delay=Width; % basic delay of input sample in sec 
DELAY=round(Delay*fs); % basic delay in # samples 
WIDTH=round(Width*fs); % modulation width in # samples 
if WIDTH>DELAY
  error('delay greater than basic delay !!!');
   return; 
end
MODFREQ=Modfreq/fs; %modulation frequency in # samples
LEN=length(x); % # of samples in WAV-file
L=2+DELAY+WIDTH*2; % length of the entire delay
Delayline=zeros(L,1); % memory allocation for delay
y=zeros(size(x)); % memory allocation for output vector
for n=1:(LEN-1)
    
   M=MODFREQ;
   MOD=sin(M*2*pi*n);
   ZEIGER=1+DELAY+WIDTH*MOD;
   i=floor(ZEIGER);
   frac=ZEIGER-i;
   Delayline=[x(n);Delayline(1:L-1)];

   y(1,n)=Delayline(i+1)*frac+Delayline(i)*(1-frac); %interpolation
end
y = (1 - mix)*y + x; % mix
end