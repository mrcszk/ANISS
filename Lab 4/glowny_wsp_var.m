N = 38e6;          % 
T = 14;
a=0.4; 
b= 0.12;   %parametry uzmiennionego wsp.zarazania - zamiast wsp. beta = 0.14;
eta = 1/70;
tk = 150;
O0 = 0.2*N;
D0 = 1;
Z0 = D0/eta;
D_pomiar = [1,4,11,17,22,31,51,68,104,125,177,238,287,358,425,536,...
  634,749,884,1051,1221,1389,1638,1862,2055,2311,2554,2946,...
  3383,3627,4102,4413,4848,5205,5575,...
  5955,6356,6674,6934,7202,7582,7918,8379,8742,9287,9593,...
  9856,10169,10511,10892,11273,11617,11902,12218,12640,12877,...
  13105,13375,13693,14006,14414,14723,15047,15366,15651,15996];
n = length(D_pomiar);      % n - liczba odczytow 
tp = 0:(n-1);              % t - wektor czasu [w dniach]

% symulacja IV
sim('epidemia_4');
delta1 = norm(ans.D_symul.Data(1:n) - D_pomiar');    % miara bledu symulacji
figure(1);
plot(ans.D_symul.Time,ans.D_symul.Data,'o',tp,D_pomiar,'kx')

% zmiana parametrow  
b = 0.115;   % modyfikacja parametru wspolczynnika w bloku f(u)
% powtorna symulacja
sim('epidemia_4');
delta2 = norm(ans.D_symul.Data(1:n) - D_pomiar');    % miara bledu symulacji
figure(2);
plot(ans.D_symul.Time,ans.D_symul.Data,'o',tp,D_pomiar,'kx')
ylabel('Liczba zdiagnozowanych');
xlabel('dni');
