  q =[2.4000    2.5600    2.5600    2.5600    2.7200    2.8800 ...
      3.2000    4.0400    5.5600    6.2000    9.3000   14.7000 ...
     18.2000   21.8000   27.8000   30.2000   31.4000   30.2000 ...
     29.0000   27.8000   25.4000   24.2000   23.0000   21.8000 ...
     21.8000   20.6000   19.4000   19.4000   18.2000   17.0000 ...
     17.0000   15.9000   14.7000   14.7000   13.5000   13.5000 ...
     12.3000   12.3000   11.1000   11.1000   10.5000   10.5000 ...
     10.5000    9.9000    9.9000    9.9000    9.3000    9.3000 ...
      9.3000    8.7000    8.7000    8.7000    8.7000    8.7000 ...
      8.1000    8.1000    8.1000    8.1000    7.3400    6.9600 ...
      6.9600    6.9600    6.9600    6.9600    6.5800    7.3400 ...
      6.9600    6.9600    6.9600 ];

  t = 1:length(q);

% Wybor zakresu aproksymacji
  q19 = q(19:end);
  n19 = length(q19);
  t19 = 1:n19;

% Normalizacja czasu do zakresu [0, 1].
  t_norm = linspace(0,1,n19);

% Funkcje aproksymujace
 
  disp('Wybierz funkcje aproksymujaca:'),
  disp('1:   f(t) = a(1) + exp(a(2)*t),'),
  disp('2:   f(t) = a(1) * exp(a(2)*t),'),
  disp('3:   f(t) = a(1) + a(2)*exp(a(3) * t),'),
  disp('4: f.wymierna  f(t) =  (a(1)*t_norm + a(2))./(a(3)*t_norm.^2 + a(4)*t_norm +a(5)),'),
  nr_fun = input('Wpisz nr funkcji: '),

  switch nr_fun
case 1
    f_aprox = @(a) a(1) + exp(a(2)*t_norm);
    a0 = [0, 1];          % Punkt startowy optymalizacji
case 2
    f_aprox = @(a) a(1) * exp(a(2)*t_norm);
    a0 = [0, 1];          % Punkt startowy optymalizacji
case 3
    f_aprox = @(a) a(1) + a(2)*exp(a(3) * t_norm);
    a0 = [1, 0, 1];      % Punkt startowy optymalizacji
case 4
    f_aprox = @(a) (a(1) + a(2)*t_norm)./(1 + a(3)*t_norm +a(4)*t_norm.^2);
    a0 = [1, 0, 1, 1];
otherwise
    disp('Nr spoza zakresu 1 - 4.'), return
  end

% Optymalizacja parametrow

  disp('Wybierz algorytm optymalizacji:'),
  disp('1:   fminsearch - bezgradientowy - Nelder - Mead,'),
  disp('2:   lsqnonlin  - specjalizowany dla nieliniowych problemów najmniejszych kwadratów,'),
  disp('3:   fminunc    - ogólny, gradientowy.'),
  nr_alg = input('Wpisz nr algorytmu: '),

  switch nr_alg
case 1
    J = @(a) sum((q19-f_aprox(a)).^2);  % suma kwadratow odleglosci od danych
    [a,fval,exitflag,output] = fminsearch(J,a0); 
    parametry2 = a,
    output.message,
    plot(t_norm,q19,'o',t_norm,f_aprox(a),'r'), hold on
case 2
    J = @(a) q19-f_aprox(a);  % suma kwadratow odleglosci od danych
    [a,resnorm,residual,exitflag,output] = lsqnonlin(J,a0); 
    parametry1 = a,
    output.message,
    plot(t_norm,q19,'o',t_norm,f_aprox(a),'b'), hold on
case 3
    J = @(a) sum((q19-f_aprox(a)).^2);  % suma kwadratow odleglosci od danych
    [a,fval,exitflag,output,grad] = fminunc(J,a0), 
    plot(t_norm,q19,'o',t_norm,f_aprox(a),'k'), hold on
otherwise
    disp('Nr spoza zakresu 1 - 3.'), return
  end
hold off






