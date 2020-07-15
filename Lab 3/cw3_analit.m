clear all
 
a=1; b=1/2; c=1; % wspolczynniki rownania 2. rzedu
y0=[1;2];         % warunki poczatkowe
tk=15;            % horyzont czasowy rozwi¹zania

% Przekszta³cenie rownania 2. rzedu do ukladu 2 rownan 1. rzedu

global A
A = [0,1;-b/a,-c/a];  % macierz wspó³czynników ukó³¹du równañ ró¿niczkowych

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Rozwiazanie analityczne:

% wyznaczanie wspolczynnikow funkcji, ktora jest rozwiazaniem:
lambda = eig(A);                  % wartosci wlasne A
alfa = real(lambda(1));           % cz. rzeczywista
omega = abs(imag(lambda(1)));     % cz. urojona

C1 = y0(1); C2 = y0(2)/omega-alfa/omega*C1;   % stale calkowania wyznaczone z warunkow poczatkowych

% Obliczanie punktow rozwiazania analitycznego

h = 0.01;             % krok punktow wykresu
t_an = 0:h:tk;        % odciete punktow wykresu
y1_an = (C1*cos(omega*t_an) + C2*sin(omega*t_an)).*exp(alfa*t_an);
y2_an = ((alfa*C1+omega*C2)*cos(omega*t_an) + (alfa*C2-omega*C1)*sin(omega*t_an)).*exp(alfa*t_an);

plot(t_an,y1_an,'b',t_an,y2_an,'r');  % wykres y1 i y2, tj. zmiennej y i jej pochodnej
hold on,
