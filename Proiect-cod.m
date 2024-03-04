%% Achizitionare de date
load("out1.mat")
timp1 = out.y.Time;
date1 = out.y.Data;

load("out2.mat")
timp2 = out.y.Time;
date2 = out.y.Data;

load("out4.mat")
timp3 = out.y.Time;
date3 = out.y.Data;

%% Filtrare date - bun

windowSize = 25;
degree = 1; % Gradul polinomului
valoriFiltrate1 = sgolayfilt(date1, degree, windowSize);
valoriFiltrate2 = sgolayfilt(date2, degree, windowSize);
valoriFiltrate3 = sgolayfilt(date3, degree, windowSize);

% Plot the filtered time series
subplot(2,1,2);
plot(timp1, valoriFiltrate1, 'r');
title('Filtered Time Series');
xlabel('Time');
ylabel('Smoothed Values');

legend('Original', 'Filtered');

%% Movmean - cel mai bun
% Set the window size for the moving average filter
window_size = 70;

% Apply a moving average filter to the first 150 data points
filtered_data1 = movmean(date1, window_size);
filtered_data2 = movmean(date2, window_size);
filtered_data3 = movmean(date3, window_size);

% Plot the results
figure;
subplot(2,1,1);
plot(date1, 'b', 'LineWidth', 1.5);
title('Original Time Series (First 150 Data Points)');

subplot(2,1,2);
plot(filtered_data1, 'r', 'LineWidth', 1.5);
title('Filtered Time Series');
legend('Original', 'Filtered');

%% Aflare lungime minima timp - inutil
minLength = min([length(filtered_data1), length(filtered_data2), length(filtered_data3)]);

% ceva bun cred 2 -  pentru filtered_data1 -  cel mai bun
for i = 1:minLength
    valoriFinale(i) = (filtered_data1(i) + filtered_data2(i) + filtered_data3(i))/3;
end

% Plot the vector
figure;
plot(valoriFinale);
title('Plot of My Vector');
xlabel('Index');
ylabel('Value');
grid on;

%% Aflare peak(valoare maxima) is timpul la care se afla
peak = max(valoriFinale);
indice_peak = find(valoriFinale == peak);
%% Identificare - gasire de lfc de ord 2 care simuleaza graficul anterior - " a ceva bun cred 2"
% am poza de acum o sapt - 12.12.2023 table, pentru determinarea functiei
% de gradul 2

num = 3.5; % Valoarea inițială a numărătorului
den = [1 1.32 0.96]; % Valoarea inițială a numitorului

H = tf(num, den); % Funcția de transfer inițială

% Calculează răspunsul treptei pentru funcția de transfer
[response, t] = step(H, timp1(1:minLength));

% Adaugă valoarea de 6 la răspunsul treptei pentru a seta condiția inițială
adjusted_response = response + 6;


figure
plot(timp1(1:minLength), valoriFinale, 'r--');
hold on
plot(t, adjusted_response, 'b--')
xlabel('Timp');
ylabel('Functii');
title('Plotare functii');
legend('Fc initiala', 'Fc de transfer gasita');

%% 
sys = tf(num, den);
C = pidtune(sys, 'PID');






