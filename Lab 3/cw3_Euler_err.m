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

% plot(t_an,y1_an,'b',t_an,y2_an,'r');  % wykres y1 i y2, tj. zmiennej y i jej pochodnej
% hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Rozwiazania numeryczne

%______________________________________________
% 1. Metoda Eulera:

h = 1;              % krok metody
t_E = 0:h:tk;       % odciete punktow, w ktorych beda obliczane przyblizenia rozwiazania
n = length(t_E);    % liczba punktow
y_E = zeros(2,n);   % pamiec dla rzednych punktow - dwa wiersze o dlugosci n
y_E(:,1) = y0;      % wpisanie warunku poczatkowego do pierwszej kolumny

% petla iteracji metody Eulera:
for i=1:n-1,
%    y_E(:,i+1) = y_E(:,i) + h*rhs(y_E(:,i));  % zapis ogolny  
  y_E(:,i+1) = y_E(:,i) + h*A*y_E(:,i);
end

% plot(t_E',y_E','o'),  % wykres rozwi¹zania metod¹ Eulera (apostrof, bo konieczna jest transpozycja)  

%______________________________________________
% 2. Metoda Rungego-Kutty (czteroetapowa) RK4
%
%h = 1/2;             % krok metody
%t_RK = 0:h:tk;       % odciete punktow, w ktorych beda obliczane przyblizenia rozwiazania
%n = length(t_RK);    % liczba punktow
%y_RK = zeros(2,n);   % pamiec dla rzednych punktow - dwie kolumny o dlugosci n
%y_RK(:,1) = y0;      % wpisanie warunku poczatkowego do pierwszej kolumny
%
%% petla iteracji 4-etapowej metody Rungego-Kutty:
%for i=1:n-1,
%  yn = y_RK(:,i);
%  k1 = h*A*yn;
%  k2 = h*A*(yn+k1/2);
%  k3 = h*A*(yn+k2/2);
%  k4 = h*A*(yn+k3);
%  y_RK(:,i+1) = yn + (k1+2*k2+2*k3+k4)/6;
%end
%
%% plot(t_RK',y_RK','x'),  % wykres rozwi¹zania metod¹ Eulera (apostrof, bo konieczna jest transpozycja)  
%
%%______________________________________________
%% 3. Algorytm adaptacyjny - metoda Rungego-Kutty typu wlozonego RK45
%
% Funkcja prawej strony uk³adu rownan 1. rzedu
%
%function yp=rhs(t,y), 
%  global A, 
%  yp=A*y; 
%end
%
%tol = 1e-4;                         % dopuszczalny b³ad wzglêdny  
%options = odeset('RelTol',tol);     % ustawienie opcji dla funkcji ode45  
%[t_RK45, y_RK45]=ode45('rhs',[0,tk],y0,options);   % rozwiazanie
%
%% plot(t_RK45, y_RK45, 'k+'),
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Obliczanie bledu przyblizonego rozwiazania 
% Zalozenie: miar¹ bledu bedzie RMSE (od ang. root mean square error),
%            czyli pierwiastek z sredniego bledu kwadratowego

% Wybór metody:
 t_ = t_E;      y_ = y_E;            % rozwiazanie przyblizone Eulera
% t_ = t_RK;     y_ = y_RK;           % rozwiazanie przyblizone m. Rungego-Kutty
% t_ = t_RK45';  y_ = y_RK45';        % rozwiazanie przyblizone algorytmu adaptacyjnego


y = (C1*cos(omega*t_) + C2*sin(omega*t_)).*exp(alfa*t_);    % rozw. dokladne
yp = ((alfa*C1+omega*C2)*cos(omega*t_) + (alfa*C2-omega*C1)*sin(omega*t_)).*exp(alfa*t_);  


delta = y_(1,:) - y;            % blad bezwzgledny
delta2 = delta * delta';  % suma kwadratow bledow (iloczyn skalarny wektora bledow)
RMSE = sqrt(delta2/length(t_)),

deltap = y_(2,:) - yp;            % blad bezwzgledny
deltap2 = deltap * deltap';  % suma kwadratow bledow (iloczyn skalarny wektora bledow)
RMSEp = sqrt(deltap2/length(t_)),



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
  
