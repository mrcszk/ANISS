% 3. Aproksymacja liniowa - badanie nadmiernego dopasowania

clear, close all
rb = 1;
x = 0:0.001:rb;  y = sin(2*pi*x); % zaleï¿½nosc aproksymowana
% Symulowane pomiary:
l_pom = 20;
x_pom = linspace(0,rb,l_pom);
y_dokl = sin(2*pi*x_pom);

sredni_blad = 0.25;               % zakï¿½adamuy poziom zaburzeï¿½ pomiarï¿½w
zaklocenie = 4*sredni_blad*(rand(1,l_pom)-0.5);
y_pom = y_dokl + zaklocenie;      % wyniki symulowanych pomiarï¿½w



% Podziaï¿½ pomiarï¿½w na zbior cwiczebny (trenigowy) i testowy
x_cw_1 = x_pom(1:2:end);  y_cw_1 = y_pom(1:2:end);       % zbior cwiczebny
x_test_1 = x_pom(2:2:end);   y_test_1 = y_pom(2:2:end);  % zbior testowy
size_cw_1 = length(x_cw_1);
size_test_1 = length(x_test_1);

% Wlasciwy podzial na zbior testowy i treningowy
len = length(x_pom); idx = randperm(len); % wektor losowych liczb z zakresu od 1 do len(x_pom)
P = round(0.6 * len); % pivot
x_cw = x_pom(idx(1:P)); y_cw = y_pom(idx(1:P));
x_test = x_pom(idx(P+1:end)); y_test = y_pom(idx(P+1:end));

size_cw = length(x_cw);
size_test = length(x_test);

n_max = 8;                    % maksymalny stopien wielomianu      
% RMSE_cw = zeros(1,size_cw); RMSE_test = zeros(1,size_test);   % tablice bï¿½ï¿½dï¿½w

for n = 1:n_max,
  p = polyfit(x_cw,y_cw,n);    % p - wspï¿½czynniki wielomianu
  p1 = polyfit(x_cw_1,y_cw_1,n);    
  
  ypa = polyval(p,x_cw);       % wartosci funkcji aproksymujï¿½cej
  ypa1 = polyval(p1,x_cw_1);
  
  dy = ypa-y_cw;
  dy1 = ypa1 - y_cw_1;
  
  RMSE_cw(n) = sqrt((dy*dy')/size_cw_1),  % blad w punktach cwiczebnych
  RMSE_cw_1(n) = sqrt((dy1*dy1')/size_cw), 
  
  y_test_a = polyval(p,x_test); % wartosci f.aproks. w punktach testowych
  y_test_a1 = polyval(p1,x_test_1); 
  
  dy_test = y_test_a-y_test; 
  dy_test_1 = y_test_a1 -y_test_1;
  
  RMSE_test(n) = sqrt((dy_test*dy_test')/size_test), % blad w punktach testowych
  RMSE_test_1(n) = sqrt((dy_test_1*dy_test_1')/size_test_1), 
  
  subplot(2,1,1)
  
  plot(x,y,'r',x_cw,y_cw,'go',x_test,y_test,'kx',x,polyval(p,x),'g-'), 
 % plot(x_cw,y_cw,'go',x_test,y_test,'kx',x,polyval(p,x),'g-'), 
  title('Z 80/20');
  legend('Rzeczywista funkcja', 'Dane treningowe', 'Dane testowe', 'Funkcja aproksymujÄ?ca')
  %legend('Dane treningowe', 'Dane testowe', 'Funkcja aproksymujÄ?ca')
  grid
  subplot(2,1,2), plot(x,polyval(p,x)-sin(2*pi*x)), 
 
  plot(x,y,'r',x_cw_1,y_cw_1,'go',x_test_1,y_test_1,'kx',x,polyval(p1,x),'g-'), 
  %plot(x_cw_1,y_cw_1,'go',x_test_1,y_test_1,'kx',x,polyval(p1,x),'g-'), 
  title('Z 50/50');
  legend('Rzeczywista funkcja', 'Dane treningowe', 'Dane testowe', 'Funkcja aproksymujÄ?ca')
  %legend('Dane treningowe', 'Dane testowe', 'Funkcja aproksymujÄ?ca')

  grid
  disp('Aby przejï¿½ï¿½ do aproksymancji kolejnym wielomianem - Naciï¿½nij ENTER');
  %if n < n_max, pause,  end
end
hold off

% Wykresy odleglosci wielomianu od zbioru cwiczebnego i testowego
subplot(2,1,1)
 plot(1:n_max,RMSE_cw,'ro-',1:n_max,RMSE_test,'bx-');
 grid
 xlabel('stopien wielomianu')
 title('Podzia³ 3:1')
 legend('blad w p. cwiczebnych','blad w p. testowych')
subplot(2,1,2)
grid
plot(1:n_max,RMSE_cw_1,'ro-',1:n_max,RMSE_test_1,'bx-');
grid
 xlabel('stopien wielomianu')
 title('Podzia³ 1:1')
 legend('blad w p. cwiczebnych','blad w p. testowych')
 