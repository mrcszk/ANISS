% 2. Aproksymacja liniowa danych zaburzonych - zaleznoœæ jakoœci aproksymacji od stopnia wielomianu
%  A.Dane teoretyczne - symulowane
 
clear, close all
x = 0:0.001:1;  y = sin(2*pi*x);  % zale¿nosc aproksymowana
% Symulacja pomiarow
l_pom = 16;
x_pom = linspace(0,1,l_pom);
y_dokl = sin(2*pi*x_pom);

sredni_blad = 0.25;               % zak³adamuy poziom zaburzeñ pomiarów
zaklocenie = 4*sredni_blad*(rand(1,l_pom)-0.5);
y_pom = y_dokl + zaklocenie;      % wyniki symulowanych pomiarów

% figure(1), plot(x,y,'r',x_pom,y_pom,'o'), % hold on,

% Petla wyznaczania wielomianow aproksymujacych
n_max = l_pom-3;                  % arbitralnie wybrany maksymalny stopien wielomianu
for n = 1:n_max,
  p = polyfit(x_pom,y_pom,n);     % p - wspó³czynniki wielomianu
  y_apr = polyval(p,x_pom);       % wartosci funkcji aproksymujacej
  dy = y_apr-y_pom;               % blad aproksymacji danych
  err(n) = sqrt((dy*dy')/l_pom);  % miara b³êdu 
  stopien_wielomianu = n,
  RMSE = err(n),
  plot(x,y,'r',x_pom,y_pom,'o',x,polyval(p,x)), 
  disp('Aby przejœæ do aproksymancji kolejnym wielomianem - Naciœnij ENTER');
  if n < n_max, pause,  end
end
RMSE = err,


