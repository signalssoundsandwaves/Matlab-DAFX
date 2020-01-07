clc;clear;
[x, fs] = audioread('DryVox.wav');
x = x';
prompt1 = '1: Amplitude modulation. 2: Graphic EQ. 3: Compression 4: Delay.';
prompt2 = '5: Schroeder Reverb. 6: Chorus. 7. Pitchshifter. other: Done.';
prompt = [prompt1 newline prompt2];
keepgoing = true;

while (true)
    selection = input(prompt);
    switch selection
        case 1
            moda = input('Input value for modulation amplitude between 0-1:');
            modf = input('Input modulation Frequency (Hz):');
            y = ampmod(x, moda, modf);
        case 2
            gain1 = input('Input gain for low shelf at 500Hz (dB):');
            gain2 = input('Input gain for band pass at 1kHz (dB):');
            gain3 = input('Input gain for band pass at 2.5kHz (dB):');
            gain4 = input('Input gain for band pass at 5kHz (dB):');
            gain5 = input('Input gain for high shelf at 10kHz (dB):');
            y = biquad_graphic_eq(x, gain1, gain2, gain3, gain4, gain5, fs);
        case 3
            thresh = input('Input threshold (dB):');
            ratio = input('Input Ratio:');
            knee = input('Input knee:');
            y = MyCompressor(x, thresh, ratio, knee, fs);
        case 4
            nTaps = input('Input the number of taps:');
            delayt = input('Set the delay time in seconds:');
            gain = input('Set a value for gain between 0-1:');
            decay = input('Set a value for the decay time between 0-1:');
            y = tap_delay(x, nTaps, delayt, gain, decay, fs);
        
        case 5
            earlyGain = input('Set a value for the gain of early reflections between 0-1:');
            lateGain = input('Set a value for the gain of late reflections between 0-1:');
            y = SchroederVerb(x, earlyGain, lateGain, fs);
        
        case 6
            Modfreq = input('Set the modulation frequency:');
            mix = input('Set a mix value between 0 - 1:');
            y = variableDelay(x, Modfreq, mix, fs);
            
        case 7
            step = input('Set the amount of pitchshift in semitones:');
            y = pitchShift(x, 1024, 256, step);
            
        otherwise
            disp('Thankyou!!');
            break;
    end

y= y/max(abs(y));
outputSelection = ["Amplitude_Modulation.wav" "Graphic_EQ.wav" "Compression.wav" "Delay.wav" "Schroeder_reverb.wav" "Chorus.wav" "pitchshift.wav"];
audiowrite(outputSelection(selection),y,fs);
sound(y,fs);

figure(1);

subplot(211);
plot(x);
grid on; title('Input Waveform')
xlabel('Time (secs)'); ylabel('Magnitude');
subplot(212);
plot(y);
grid on; title('Output Waveform')
xlabel('Time (secs)'); ylabel('Magnitude');

Nx = length(x);
lenx = Nx/2;
X = fft(x,Nx);

magsX = abs(X); 

magsX = magsX(1:lenx);

binsX = linspace(0, fs/2, lenx);

Ny = length(y);
leny = round(Ny/2);
Y = fft(y,Ny);

magsY = abs(Y);

magsY = magsY(1:leny);

binsY = linspace(0, fs/2, leny);

figure(2);
subplot(211); plot(binsX, magsX, 'k'); grid on; title('Input Magnitude Spectrum')
xlabel('Frequency (Hz)'); ylabel('Magnitude');
subplot(212); plot(binsY, magsY, 'k'); grid on; title('Output Magnitude Spectrum')
xlabel('Frequency (Hz)'); ylabel('Magnitude');

end





