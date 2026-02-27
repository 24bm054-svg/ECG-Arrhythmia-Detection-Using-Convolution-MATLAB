clc;
clear;
close all;

% Step 1: Generate Sample ECG Signal
fs = 360;                     % Sampling frequency

t = 0:1/fs:5;                 % 5 seconds duration
ecg = 1.2*sin(2*pi*1.2*t) + 0.25*sin(2*pi*2.4*t);

% Add noise
noise = 0.5*randn(size(t));
noisy_ecg = ecg + noise;

% Step 2: Design FIR Low Pass Filter
N = 50;                       % Filter order
fc = 40;                      % Cutoff frequency
h = fir1(N, fc/(fs/2));       % FIR filter coefficients

% Step 3: Apply Convolution
filtered_ecg = conv(noisy_ecg, h, 'same');

% Step 4: Plot Signals
figure;
subplot(3,1,1);
plot(t, ecg);
title('Original ECG Signal');

subplot(3,1,2);
plot(t, noisy_ecg);
title('Noisy ECG Signal');

subplot(3,1,3);
plot(t, filtered_ecg);
title('Filtered ECG Signal using Convolution');

% Step 5: R-peak Detection
[pks, locs] = findpeaks(filtered_ecg, 'MinPeakHeight',0.8);

RR_intervals = diff(locs)/fs;
heart_rate = 60/mean(RR_intervals);

disp(['Heart Rate = ', num2str(heart_rate), ' BPM']);

% Arrhythmia Check
if heart_rate < 60
    disp('Bradycardia Detected');
elseif heart_rate > 100
    disp('Tachycardia Detected');
else
    disp('Normal Heart Rhythm');
end

%opening current folder