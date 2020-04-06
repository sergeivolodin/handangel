clc
clear

%% Need to change for each measurement
IMU = csvread('data_1.csv');
ref = csvread('ref_1.csv');
start_data = 700; %for data_1
% start_data = 483; %for data_2
% start_data = 406; %for data_3

%%
Fs = 128;

Wn = [8]*2/Fs; % cutt off based on fs
[A,B] = butter(3,Wn); %bandpass filtering
IMU = filtfilt(A,B,IMU);
IMU = IMU(start_data:end,:);
acc_vec = vecnorm(IMU(:,1:3)')' - 1;
window_size = 3; %sec
step_size = 128;

%% features
j = 1;
for i = 1:step_size:length(IMU)-step_size*window_size
    x(j,1:3) = mean(IMU(i:i+window_size*Fs,1:3));
    x(j,4:6) = std(IMU(i:i+window_size*Fs,1:3));
    x(j,7:9) = min(IMU(i:i+window_size*Fs,1:3));
    x(j,10:12) = max(IMU(i:i+window_size*Fs,1:3));
    x(j,13) = sum(abs(IMU(i:i+window_size*Fs,1)));
    x(j,14) = sum(abs(IMU(i:i+window_size*Fs,2)));
    x(j,15) = sum(abs(IMU(i:i+window_size*Fs,3)));
    x(j,16) = sum((IMU(i:i+window_size*Fs,1)).^2);
    x(j,17) = sum((IMU(i:i+window_size*Fs,2)).^2);
    x(j,18) = sum((IMU(i:i+window_size*Fs,3)).^2);
    j = j+1;
end

j = 1;
for i = 1:step_size:length(IMU)-step_size*window_size
    XX = acc_vec(i:i+window_size*Fs);          
    YY = fft(XX,1000);
    L = length(YY);
    P2 = abs(YY/L);
    P1 = P2(1:fix(L/2)+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:(L/2))/L;
    [~,I] = maxk(P1,1);
    
    x(j,19) = P1(I);
    x(j,20) = f(I);
    j = j+1;
end

ref = ref(1:length(x));
Z = [x ref];
[trainedClassifier, validationAccuracy] = trainClassifier(Z);
[trainedClassifierSVM, validationAccuracySVM] = trainClassifierSVM(Z);