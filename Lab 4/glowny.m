clear;
N = 38e6;     % liczebnosc poputacji
T = 14;       % okres leczenia (prawdopodobnie T=30 byloby lepszym przyblizeniem
beta = 0.1;   % wspolczynnik zarazania
eta = 1/70;   % wspolczynnik diagnozowania wirusa  
tk = 1000;    % horyzont symulacji
O0 = 0.2*N;   % wartosci poczatkowe
D0 = 1;
Z0 = D0/eta;
% Liczby osob zdiagnozowanych pozytywnie - dane od 4.03 do 22.05.2020
D_pomiar = [1,4,11,17,22,31,51,68,104,125,177,238,287,358,425,536,...
  634,749,884,1051,1221,1389,1638,1862,2055,2311,2554,2946,...
  3383,3627,4102,4413,4848,5205,5575,...
  5955,6356,6674,6934,7202,7582,7918,8379,8742,9287,9593,...
  9856,10169,10511,10892,11273,11617,11902,12218,12640,12877,...
  13105,13375,13693,14006,14414,14723,15047,15366,15651,15996,...
  16326,16882,17204,17615,18016,18257,18529,18885,19268,19738,20143,20619];    
tp = 0:(length(D_pomiar)-1);          % t - wektor czasu [w dniach]

%  Wywolanie symulacji:

% symulacja I
sim('epidemia.slx');     
figure(1),
plot(ans.Zout);

% symulacja II
%sim('epidemia_2.slx');     
%figure(2),
%plot(ans.Zout);


% symulacja III
%sim('epidemia_3.slx');     
%figure(3),
%plot(ans.Zout);




