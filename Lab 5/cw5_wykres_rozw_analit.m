% Rozwiazanie analityczne:

ti = [0,    7.05, 14.24, 21.95, 30.00, 38.32, 47.08, 56.46, 66.89, 78.72, 90.65, 104.58, 113.64, 123.07, 135.75 ];
hi = [0.13, 0.12,  0.11,  0.10,  0.09,  0.08,  0.07,  0.06,  0.05,  0.04,  0.03,   0.02,   0.015,  0.01,   0.005];

tk = ti(end);     % horyzont symulacji
h0 = hi(1);       % warunek pocz¹tkowy

a = 0.009;   % srednica rurki wyp³ywowej
A = 0.218;   % srednica zbiornika
g = 9.81;    % przyspieszenie ziemskie

k = a^2/A^2 * sqrt(2*g);

t_an = 0:0.1:tk;
h_an = (sqrt(h0) - k*t_an/2).^2;

plot(t_an,h_an,'k');
hold on
plot(ti,hi,'ro');


  
