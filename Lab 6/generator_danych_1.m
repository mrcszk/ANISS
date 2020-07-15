% 1 B. Aproksymacja liniowa danych dok³adnych - zaleznoœæ jakoœci aproksymacji od stopnia wielomianu

clear all, close all,
format compact,

% Dane s¹ punktami funkcji  sinus:
x = 0:0.001:1;  y = sin(2*pi*x);   % zale¿nosc aproksymowana

l_pom = 50;
x_pom= linspace(0,1,l_pom);
y_dokl = sin(2*pi*x_pom);
y_pom = y_dokl;

figure(1), plot(x,y,'r',x_pom,y_pom,'.'), 

% Aproksymacja wielomianami stopnia n od 1 do n_max
n_max = 15;
for n = 1:n_max,
  p = polyfit(x_pom,y_pom,n);     % p - wspó³czynniki wielomianu
  y_aprox = polyval(p,x_pom);     % wartosci funkcji aproksymuj±cej
  dy = y_aprox - y_pom;           % blad aproksymacji danych
  err(n) = sqrt((dy*dy')/l_pom);  % miara b³êdu - RMSE 
  disp('Stopien wielomianu'), n,
  blad = err(n),
  subplot(2,1,1), plot(x,polyval(p,x),x_pom,y_pom,'.'),
  title('Pomiary i funkcja aproksymuj¹ca');
  subplot(2,1,2), plot(x,polyval(p,x)-sin(2*pi*x)), 
  title('Funkcja aproksymujaca - funkcja aproksymowana'); 
  if n < n_max, 
      disp('Aby przejœæ do aproksymancji kolejnym wielomianem - Naciœnij ENTER');
	  pause,  
  end
end



