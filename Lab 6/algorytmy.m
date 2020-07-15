% 1 A. Aproksymacja wielomianowa 
%      Obliczanie wspolczynników wielomianu 
%      - za pomoc¹ macierzy Vandermonde'a:
%        * z odwracaniem macierzy,
%        * z "lewym dzieleniem przez macierz" tzm. rozwiazywaniem ukladu rownan liniowych
%      - procedura specjalizowana MATLABa dla aproksymacji wielomianowej - polyfit

clear all, close all
format compact,  format short e
x = [-1.5:0.1:1.5]';    % Przyklad generowania danych dla aproksymacji (bez "b³êdu pomiarowego")
y = exp(x);             % punkty aproksymowane leza nale¿¹ do wykresu funkcji wykaadniczej

V1 = vander(x);         % utworzene macierzy Vandrmonde'a - wiecej inf. w help vander
V = V1(:,end:-1:1);     % odwrocenie kolejnosci kolumn macierzy

x_plot = linspace(x(1),x(end),1000); % wektor odcietych x dla rysowania funkcji ciaglych
  
for p = 1:23,           % petla po kolejnych stopniach p wielomianu aproksymujacego 
  A = V(:,1:p+1);       % przepisanie do A p+1 kolumn macierzy Vandermonde'a
  A_tr_A = (A'*A);        % iloczyn A transponowane * A

% algorytm 1: z odwracaniem macierzy  
  a1 = inv(A_tr_A)*A'*y;  % a1 - wektor wspolczynnikow wielomianu aproksymujacego
  ya1 = polyval(a1(end:-1:1),x);  % ya1 - wartosci wielomianu aproksymujacego
  d1 = norm(y-ya1);       % obliczenie RMSE (MSE mozna obliczyc jako iloczyn skalarny: d1 = y' * ya1
  
% algorytm 2: z "lewym dzieleniem macierzy"    
  a2 = A_tr_A\(A'*y);     % a2 - wektor wspolczynnikow wielomianu aproksymujacego
  ya2 = polyval(a2(end:-1:1),x);  % ya2 - wartosci wielomianu aproksymujacego
  d2 = norm(y-ya2);       % obliczenie RMSE (MSE mozna obliczyc jako iloczyn skalarny: d2 = y' * ya2
  
% algorytm 3: z funkcja specjalizowana MATLABa
  a3 = polyfit(x,y,p);   % p - wspó³czynniki wielomianu
  ya3 = polyval(a3,x);    % ya3 - wartosci wielomianu aproksymujacego
  d3 = norm(y-ya3);
  
  disp('Stopieñ  RMSE (alg.1)  RMSE (alg.2)  RMSE (alg.3)');  
  [p,d1,d2,d3]  
  plot(x,y,'.',x_plot,polyval(a1(end:-1:1),x_plot),'g',x_plot,polyval(a2(end:-1:1),x_plot),'r',x_plot,polyval(a3,x_plot),'k'); 
  disp('Aby przejœæ do aproksymancji kolejnym wielomianem - Naciœnij ENTER');
  pause 
end

