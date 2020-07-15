% 3. Aproksymacja liniowa - badanie nadmiernego dopasowania

clear, close all
x = 0:0.001:1;  y = sin(2*pi*x); % zale¿nosc aproksymowana
% Symulowane pomiary:
l_pom = 16;
x_pom = linspace(0,1,l_pom);
y_dokl = sin(2*pi*x_pom);

sredni_blad = 0.25;               % zak³adamuy poziom zaburzeñ pomiarów
zaklocenie = 4*sredni_blad*(rand(1,l_pom)-0.5);
y_pom = y_dokl + zaklocenie;      % wyniki symulowanych pomiarów

% Podzia³ pomiarów na zbior cwiczebny (trenigowy) i testowy
x_cw = x_pom(1:2:end);  y_cw = y_pom(1:2:end);       % zbior cwiczebny
x_test = x_pom(2:2:end);   y_test = y_pom(2:2:end);  % zbior testowy
size_cw = length(x_cw);
size_test = length(x_test);

n_max = 8;                    % maksymalny stopien wielomianu      
% RMSE_cw = zeros(1,size_cw); RMSE_test = zeros(1,size_test);   % tablice b³êdów

for n = 1:n_max,
  p = polyfit(x_cw,y_cw,n);    % p - wspó³czynniki wielomianu
  ypa = polyval(p,x_cw);       % wartosci funkcji aproksymuj±cej
  dy = ypa-y_cw; 
  RMSE_cw(n) = sqrt((dy*dy')/size_cw),  % blad w punktach cwiczebnych
  
  y_test_a = polyval(p,x_test); % wartosci f.aproks. w punktach testowych
  dy_test = y_test_a-y_test; 
  RMSE_test(n) = sqrt((dy_test*dy_test')/size_test), % blad w punktach testowych

  plot(x,y,'r',x_cw,y_cw,'go',x_test,y_test,'kx',x,polyval(p,x),'g-'), 
  disp('Aby przejœæ do aproksymancji kolejnym wielomianem - Naciœnij ENTER');
  %if n < n_max, pause,  end
end
hold off

% Wykresy odleglosci wielomianu od zbioru cwiczebnego i testowego
 figure(2), plot(1:n_max,RMSE_cw,'ro-',1:n_max,RMSE_test,'bx-');
 xlabel('stopien wielomianu')
 legend('blad w p. cwiczebnych','blad w p. testowych')
