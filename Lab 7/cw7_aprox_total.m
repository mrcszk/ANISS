% function aprox2   % po odkomentowaniu - tak¿e end w linii 103
wersja = 2019;      % 2013 (lub octave) albo 2019 - wersje MATLABa 
format compact

% daty: 6.03.2020   pierwszy zara¿ony
%      14.03.2020   zamkniecie szkol itp.
%      26.03.2020   ograniczenia mozliwosci kontaktowania sie

% Sumaryczna liczba zdiagnozowanych przypadków (od 6 marca 2020) 
LZ = [1,4,11,17,22,31,51,68,104,125,177,238,287,358,425,536,...
  634,749,884,1051,1221,1389,1638,1862,2055,2311,2554,2946,...
  3383,3627,4102,4413,4848,5205,5575,...
  5955,6356,6674,6934,7202,7582,7918,8379,8742,9287,9593,...
  9856,10169,10511,10892,11273,11617,11902,12218,12640,12877,...
  13105,13375,13693,14006,14414,14723,15047,15366,15651,15996];

  t = 0:(length(LZ)-1);          % t - wektor czasu [w dniach]
  n = length(t);    n1 = n-1;    % n - liczba dni;

% Normalizacja czasu - do przedzia³u [0,1]
  t_norm = linspace(0,1,n);

% Funkcja aproksymujaca i punkt startowy a0:
  f_aprox = @(a) a(1) + a(2)*exp((a(3)*atan(a(4)*t_norm + a(5)) - a(6)) .* t_norm);
  a0 = [0, 1, 1, 1, 0, 0];
%  a0 = [-1, 30, -1, 20, 0.2, -pi/2];  
%  a0 = [6  8  -0.15   0.03*65  -0.5  -0.26*65];

% Miara odleg³oœci funkcji od danych:
  J2 = @(a) sum((LZ-f_aprox(a)).^2);     % suma kwadratow - ew. zastapiona funkcj¹ ponizej
%  J_abs = @(a) sum(abs(LZ-f_aprox(a)));  % suma bezwzglednych wartosci

% Obliczanie optymalnych parametrow funkcji aproksymujacej:

  nr_alg = input('Wpisz nr algorytmu [1: Nelder-Mead,  2: lsqnonlin,  3-4: fminunc]: ');

  switch nr_alg
case 1
    disp(' '),
    disp('Algorytm bezgradientowy Neldera Meada:')
    disp(' '),   
    options1 = optimset('MaxFunEvals',50000,'MaxIter',50000);
    tic,                    % pocz¹tek pomiaru czasu
    [a,fval,exitflag,output] = fminsearch(J2,a0,options1), 
    elapsedtime1 = toc,     % koniec pomiaru czasu
case 2
    disp(' '),
    disp('Algorytm specjalizowany dla najmniejszej sumy kwadratów:'),
    disp(' '),
    delta = @(a) LZ-f_aprox(a);      % wektor odleglosci - dla lsqnonlin
    if wersja == 2013,
      options2 = optimoptions('lsqnonlin','MaxFunEvals',5000,'MaxIter',5000);
    else
      options2 = optimoptions('lsqnonlin','MaxFunctionEvaluations',500,'MaxIterations',500);
    end
    tic,                    % pocz¹tek pomiaru czasu
    [a,resnorm,residual,exitflag,output] = lsqnonlin(delta,a0,[],[],options2), 
    elapsedtime2 = toc,     % koniec pomiaru czasu
case 3
    disp(' '),
    disp('Algorytm z numerycznyym obliczaniem gradientu:'),
    disp(' '),
    tic,                    % pocz¹tek pomiaru czasu
    if wersja == 2013,
      options3 = optimoptions('fminunc','MaxFunEvals',15000,'MaxIter',15000);
    else
      options3 = optimoptions('fminunc','MaxFunctionEvaluations',500,'MaxIterations',500,'OptimalityTolerance',1e-9);
    end
    [a,fval,exitflag,output,grad] = fminunc(J2,a0,options3); 
    elapsedtime3 = toc,     % koniec pomiaru czasu
case 4    
    disp(' '),
    disp('Algorytm z analitycznym obliczaniem gradientu:'),
    disp(' '),
    if wersja == 2013,
      options3G = optimoptions('fminunc','MaxFunEvals',500,'MaxIter',500);
    else
      options3G = optimoptions('fminunc','SpecifyObjectiveGradient',true,'MaxFunctionEvaluations',500,'MaxIterations',500,'OptimalityTolerance',1e-9);
    end
    fun = @J2G;
    tic,                    % pocz¹tek pomiaru czasu
    [a,fval,exitflag,output,grad] = fminunc(fun,a0,options3G); 
    elapsedtime4 = toc,     % koniec pomiaru czasu
otherwise
    disp('Numer spoza zakresu 1-3.'), return
  end
    algorytm = output.algorithm,
    liczba_iteracji = output.iterations,
	kod_wyjscia = exitflag,
	output.message,

  figure(1), plot(t_norm,LZ,'o',t_norm,f_aprox(a)),
  xlabel('Znormalizowany czas'); ylabel('Liczba zdiagnozowanych');
  figure(2), plot(t_norm, a(3)*atan(a(4)*t_norm + a(5)) - a(6));
  xlabel('Znormalizowany czas'); ylabel('Wspolczynnik w wykladnitu');


%_____________________________________________
% Wykresy w czasie nie normalizowanym
a = [a(1), a(2), a(3)/n1, a(4)/n1, a(5), a(6)/n1];
f_aprox_real = @(a) a(1) + a(2)*exp((a(3)*atan(a(4)*t + a(5)) - a(6)) .* t);
figure(11), plot(t,LZ,'o',t,f_aprox_real(a)),
figure(12), plot(t, a(3)*atan(a(4)*t + a(5)) - a(6));

%end

%___________________________________________________

% Funkcja aproksymujaca i jej pochodne wzgledem parametrow
function [f,df] = f_aprox2(a),
  n = 66;
  t = linspace(0,1,n);
  f = a(1) + a(2)*exp((a(3)*atan(a(4)*t + a(5)) - a(6)) .* t);

  p1 = ones(1,n);
  p2 = exp(-t.*(a(6) - a(3)*atan(a(5) + a(4)*t)));
  p3 = a(2)*t.*atan(a(5) + a(4)*t).*p2;
  p4 = (a(2)*a(3)*t.^2.*p2)./((a(5) + a(4)*t).^2 + 1);
  p5 = (a(2)*a(3)*t.*p2)./((a(5) + a(4)*t).^2 + 1);
  p6 = -a(2)*t.*p2;
  df = [p1; p2; p3; p4; p5; p6];
end
%___________________________________________________

% Funkcja obliczajaca wskaznik jakosci i jego gradient
function [J, GradJ] = J2G(a),
  LZ=[1,4,11,17,22,31,51,68,104,125,177,238,287,358,425,536,...
  634,749,884,1051,1221,1389,1638,1862,2055,2311,2554,2946,...
  3383,3627,4102,4413,4848,5205,5575,...
  5955,6356,6674,6934,7202,7582,7918,8379,8742,9287,9593,...
  9856,10169,10511,10892,11273,11617,11902,12218,12640,12877,...
  13105,13375,13693,14006,14414,14723,15047,15366,15651,15996];
  
  [f,df] = f_aprox2(a);
  odleglosc = LZ-f;
  J = sum(odleglosc.^2);
  GradJ = zeros(6,1);
  GradJ(1) = -sum(2*odleglosc.*df(1,:));
  GradJ(2) = -sum(2*odleglosc.*df(2,:));
  GradJ(3) = -sum(2*odleglosc.*df(3,:));
  GradJ(4) = -sum(2*odleglosc.*df(4,:));
  GradJ(5) = -sum(2*odleglosc.*df(5,:));
  GradJ(6) = -sum(2*odleglosc.*df(6,:));
end
%___________________________________________________


