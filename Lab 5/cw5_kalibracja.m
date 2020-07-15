%clear all
%close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Pomiary

ti = [0,    7.05, 14.24, 21.95, 30.00, 38.32, 47.08, 56.46, 66.89, 78.72, 90.65, 104.58, 113.64, 123.07, 135.75 ];
hi = [0.13, 0.12,  0.11,  0.10,  0.09,  0.08,  0.07,  0.06,  0.05,  0.04,  0.03,   0.02,   0.015,  0.01,   0.005];

tk = ti(end);
h0 = hi(1);

xi = sqrt(h0)-sqrt(hi);
yi = ti; 

% Optymalizacja uwzglêdniaj¹ca wszystkie dane pomiarowe

c_opt = (yi*xi')/(xi*xi');
k_opt = 2/c_opt,

delta2 = (yi - c_opt*xi);
J_opt = delta2*delta2'/length(xi),
RMSE_opt = sqrt(J_opt),

t_an = 0:0.1:tk;
h_an_opt = (sqrt(h0) - k_opt*t_an/2).^2; 

plot(ti,hi,'ro',t_an,h_an_opt,'m');
hold on
k = 0.0042;
t_an = 0:0.1:tk;
h_an = (sqrt(h0) - k*t_an/2).^2;
plot(t_an,h_an,'k');




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% Optymalizacja uwzglêdniaj¹ca dane nad sto¿kiem

 ti10 = ti(1:10);   hi10 = hi(1:10);
%
 xi10 = sqrt(h0)-sqrt(hi10);
 yi10 = ti10; 
% 
 c_opt10 = (yi10*xi10')/(xi10*xi10');
 k_opt10 = 2/c_opt10,
%
 delta210 = (yi10 - c_opt10*xi10);
 J_opt10 = delta210*delta210'/length(xi10),
%
 h_an_opt10 = (sqrt(h0) - k_opt10*t_an/2).^2; 
RMSE_opt10 = sqrt(J_opt10)
 plot(ti,hi,'ro',ti10,hi10,'r.',t_an,h_an_opt10,'g');
 legend('pomiar 1-15','kalibracja 1-15','pomiar 1-10', 'kalibracja 1-10');



