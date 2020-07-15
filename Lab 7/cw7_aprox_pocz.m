% function aprox
wersja = 2019;
format short e
% clear all, close all

% t0 = 6.03.2020   poczatek
%     14.03.2020   zamkniecie szkol itd
%     26.03.2020   ograniczenia mozliwosci kontaktowania sie

% Sumaryczna liczba zdiagnozowanych przypadków (od t0) 
LZ = [1,4,11,17,22,31,51,68,104,125,177,238,287,358,425,536,...
634,749,884,1051,1221,1389,1638,1862,2055,2311,2554,2946,...
3383,3627,4102,4413,4848,5205,5575,...
5955,6356,6674,6934,7202,7582,7918,8379,8742,9287,9593,...
9856,10169,10511,10892,11273,11617,11902,12218,12640,12877,...
13105,13375,13693,14006,14414,14723,15047,15366,15651,15996];

% Ograniczenie przedzia³u aproksymacji - faza I (pierwsze 21 dni)
LZ = LZ(1:21);

t = 0:(length(LZ)-1);          % t - wektor czasu [w dniach]
n = length(t);    n1 = n-1;    % n - liczba dni;

% Normalizacja czasu - do przedzia³u [0,1]
t_norm = linspace(0,1,n);

% Wybór funkcji aproksymujacej 
% i punktu startowego a0 - pocz¹tkowych wartoœci parametrów:

% Funkcje aproksymujace
 
  disp('Wybierz funkcje aproksymujaca:'),
  disp('1:   f(t) = a(1) + exp(a(2)*t),'),
  disp('2:   f(t) = a(1) * exp(a(2)*t),'),
  disp('3:   f(t) = a(1) + a(2)*exp(a(3) * t),'),
  nr_fun = input('Wpisz nr funkcji: '),

  switch nr_fun
case 1
    f_aprox = @(a) a(1) + exp(a(2)*t_norm);
    a0 = [1, 1];          % Punkt startowy optymalizacji
case 2
    f_aprox = @(a) a(1) * exp(a(2)*t_norm);
    a0 = [1, 1];          % Punkt startowy optymalizacji
case 3
    f_aprox = @(a) a(1) + a(2)*exp(a(3) * t_norm);
    a0 = [1, 1, 1];      % Punkt startowy optymalizacji
otherwise
    disp('Nr spoza zakresu 1 - 3.'), return
  end

 %f_aprox = @(a) a(1) + a(2)*exp((a(3)*atan(a(4)*t_norm + a(5)) - a(6)) .* t_norm);
 a0 = [-1,30,-1,20,0.2,-pi/2];  

% Miara odleg³oœci funkcji od danych:
  J2 = @(a) sum((LZ-f_aprox(a)).^2);     % suma kwadratow - ew. zastapiona funkcj¹ ponizej

% Obliczanie optymalnych parametrow funkcji aproksymujacej:

  nr_alg = input('Wpisz nr algorytmu [1: Nelder-Mead,  2: lsqnonlin,  3-4: fminunc]: ');

  switch nr_alg
case 1
    disp(' '),
    disp('Algorytm bezgradientowy Neldera Meada:')
    disp(' '),   
    options1 = optimset('MaxFunEvals',500,'MaxIter',500);
    tic,                    % pocz?tek pomiaru czasu
    [a,fval,exitflag,output] = fminsearch(J2,a0,options1), 
    elapsedtime1 = toc,     % koniec pomiaru czasu
case 2
    disp(' '),
    disp('Algorytm specjalizowany dla najmniejszej sumy kwadratów:'),
    disp(' '),
    delta = @(a) LZ-f_aprox(a);      % wektor odleglosci - dla lsqnonlin
    if wersja == 2013,
      options2 = optimoptions('lsqnonlin','MaxFunEvals',500,'MaxIter',500);
    else
      options2 = optimoptions('lsqnonlin','MaxFunctionEvaluations',500,'MaxIterations',500);
    end
    tic,                    % pocz?tek pomiaru czasu
    [a,resnorm,residual,exitflag,output] = lsqnonlin(delta,a0,[],[],options2), 
    elapsedtime2 = toc,     % koniec pomiaru czasu
case 3
    disp(' '),
    disp('Algorytm z numerycznyym obliczaniem gradientu:'),
    disp(' '),
    tic,                    % pocz?tek pomiaru czasu
    if wersja == 2013,
      options3 = optimoptions('fminunc','MaxFunEvals',500,'MaxIter',500);
    else
      options3 = optimoptions('fminunc','MaxFunctionEvaluations',500,'MaxIterations',500,'OptimalityTolerance',1e-9);
    end
    [a,fval,exitflag,output,grad] = fminunc(J2,a0,options3); 
    elapsedtime3 = toc,     % koniec pomiaru czasu
otherwise
    disp('Numer spoza zakresu 1-3.'), return
  end
    algorytm = output.algorithm,
    liczba_iteracji = output.iterations,
	kod_wyjscia = exitflag,
	output.message,

  %figure(1), plot(t_norm,LZ,'o',t_norm,f_aprox(a)),
  %xlabel('Znormalizowany czas'); ylabel('Liczba zdiagnozowanych');
 

%_____________________________________________
 % Wykresy w czasie nie normalizowanym
 a = [a(1), a(2), a(3)/n1, a(4)/n1, a(5), a(6)/n1];
 f_aprox_real = @(a) a(1) + a(2)*exp((a(3)*atan(a(4)*t + a(5)) - a(6)) .* t);
 figure(11), plot(t,LZ,'o',t,f_aprox_real(a)),
 figure(12), plot(t, a(3)*atan(a(4)*t + a(5)) - a(6));


