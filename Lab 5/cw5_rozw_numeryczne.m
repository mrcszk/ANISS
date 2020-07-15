%clear all
%close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Pomiary

ti = [0,    7.05, 14.24, 21.95, 30.00, 38.32, 47.08, 56.46, 66.89, 78.72, 90.65, 104.58, 113.64, 123.07, 135.75 ];
hi = [0.13, 0.12,  0.11,  0.10,  0.09,  0.08,  0.07,  0.06,  0.05,  0.04,  0.03,   0.02,   0.015,  0.01,   0.005];

 plot(ti,hi,'ro'); ylabel('Wysokosc lustra wody [m]'); xlabel('czas [s]');
 hold on;

tk = ti(end);    % horyzont symulacji
h0 = hi(1);       % warunek pocz¹tkowy

% Pasrametry obiektu
a = 0.009;   % srednica rurki wyp³ywowej
A = 0.218;   % srednica zbiornika
g = 9.81;    % przyspieszenie ziemskie

k = a^2/A^2 * sqrt(2*g);    % parametr modelu

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rozwiazania numeryczne
% Metoda Rungego-Kutty (czteroetapowa) RK4

krok = 1;             % krok metody
t_RK = 0:krok:tk;       % odciete punktow, w ktorych beda obliczane przyblizenia rozwiazania
n = length(t_RK);    % liczba punktow
h_RK = zeros(2,n);   % pamiec dla rzednych punktow - dwie kolumny o dlugosci n
h_RK(:,1) = h0;      % wpisanie warunku poczatkowego do pierwszej kolumny

% petla iteracji 4-etapowej metody Rungego-Kutty:
for i=1:n-1,
  yn = h_RK(:,i);
  k1 = krok*(-k*sqrt(yn));
  k2 = krok*(-k*sqrt(yn+k1/2));
  k3 = krok*(-k*sqrt(yn+k2/2));
  k4 = krok*(-k*sqrt(yn+k3));
  h_RK(:,i+1) = yn + (k1+2*k2+2*k3+k4)/6;
end

plot(t_RK',h_RK','bx'),  % wykres rozwi¹zania metod¹ RK4  
hold on,
%[t_RK45, y_RK45]=ode45('rhs',[0,tk],y0,options);
[J_1, J_2, J_inf] = cw5_blad_symulacji(k)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%% Procedura rezerwowa - na przypadek, gdyby ogólna dzialala:
%
%%______________________________________________
%% 2. Metoda Rungego-Kutty RK4 (gdyby dzialal z funkcja rhs)
%
%function ynp = rk4(tn,yn,h);
%  k1 = h*rhs(tn,yn);
%  k2 = h*rhs(tn+h/2, yn+k1/2);
%  k3 = h*rhs(tn+h/2, yn+k2/2);
%  k4 = h*rhs(tn+h, yn+k3);
%  ynp1 = yn + (k1+2*k2+2*k3+k4)/6;
%end
%
%h = 1;             % krok metody
%t_RK = 0:h:tk;       % odciete punktow, w ktorych beda obliczane przyblizenia rozwiazania
%n = length(t_RK);    % liczba punktow
%y_RK = zeros(2,n);   % pamiec dla rzednych punktow - dwie kolumny o dlugosci n
%y_RK(:,1) = y0;      % wpisanie warunku poczatkowego do pierwszej kolumny
%
%% petla iteracji 4-etapowej metody Rungego-Kutty:
%for i=1:n-1,
%  y_RK(:,i+1) = rk4(t_RK(i),y_RK(:,i),h);
%end
%
%plot(t_RK',y_RK','*'),  % wykres rozwi¹zania metod¹ Eulera (apostrof, bo konieczna jest transpozycja)  
  
