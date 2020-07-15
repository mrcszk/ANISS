clear all
 
a=1; b=1/2; c=1;  % wspolczynniki rownania 2. rzedu
y0=[1;2];         % warunki pocz¹tkowe
tk=50;            % horyzont czasowy rozwi¹zania

global A
A = [0,1;-b/a,-c/a];  % macierz wspó³czynników uk³adu równañ ró¿niczkowych

lambda = eig(A);                  % wartosci wlasne A
alfa = real(lambda(1));           % cz. rzeczywista
omega = abs(imag(lambda(1)));     % cz. urojona
C1 = y0(1); C2 = y0(2)/omega-alfa/omega*C1;   % stale calkowania wyznaczone z warunkow poczatkowych

H = [4,2,1,1/2,1/4,1/16,1/32,1/62,0.01,0.001,0.0001];

% 1. Metoda Eulera:
Euler = []; EE = [];

tic;
for h = H
    t_E = 0:h:tk;       % odciete punktow, w ktorych beda obliczane przyblizenia rozwiazania
    n = length(t_E);    % liczba punktow
    y_E = zeros(2,n);   % pamiec dla rzednych punktow - dwa wiersze o dlugosci n
    y_E(:,1) = y0;      % wpisanie warunku poczatkowego do pierwszej kolumny
    y = (C1*cos(omega*t_E) + C2*sin(omega*t_E)).*exp(alfa*t_E);    % rozw. dokladne
    
    for i=1:n-1
        y_E(:,i+1) = y_E(:,i) + h*A*y_E(:,i);
    end
    
    delta = y_E(1,:) - y;            % blad bezwzgledny
    delta2 = delta * delta';  % suma kwadratow bledow (iloczyn skalarny wektora bledow)
    EE = [EE,sqrt(delta2/length(t_E))];
    Euler = [Euler; toc];
end

% 2. RK4
RK = [];
ERK = [];
tic
for h = H   
    t_RK = 0:h:tk;       % odciete punktow, w ktorych beda obliczane przyblizenia rozwiazania
    n = length(t_RK);    % liczba punktow
    y_RK = zeros(2,n);   % pamiec dla rzednych punktow - dwie kolumny o dlugosci n
    y_RK(:,1) = y0;      % wpisanie warunku poczatkowego do pierwszej kolumny
    
    y_ = y_RK;    
    y = (C1*cos(omega*t_RK) + C2*sin(omega*t_RK)).*exp(alfa*t_RK);    % rozw. dokladne
    
    for i=1:n-1
      yn = y_RK(:,i);
      k1 = h*A*yn;
      k2 = h*A*(yn+k1/2);
      k3 = h*A*(yn+k2/2);
      k4 = h*A*(yn+k3);
      y_RK(:,i+1) = yn + (k1+2*k2+2*k3+k4)/6;
    end    
    
    delta = y_RK(1,:) - y;            
    delta2 = delta * delta';  
    RK = [RK;toc];
    ERK = [ERK;sqrt(delta2/length(t_RK))];
end
tic
tol = 1e-2;                         % dopuszczalny b³ad wzglêdny  
options = odeset('RelTol',tol);     % ustawienie opcji dla funkcji ode45  
[t_RK45, y_RK45]=ode45('rhs',[0,tk],y0,options)   % rozwiazanie
toc 
fprintf('Krok metody    Czas wykonania M. Eulera       B³¹d M. Eulera        Czas wykonania M. RK       B³¹d M. RK \n')
for i=1:length(H)
    fprintf('h = %f       Euler = %f      Euler b³¹d = %12e       RK = %f     RK b³¹d = %9e     \n', H(i),Euler(i), EE(i), RK(i), ERK(i))
end


