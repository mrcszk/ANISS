
% 2. Aproksymacja liniowa danych zaburzonych - zalezno�� jako�ci aproksymacji od stopnia wielomianu
%  B.Dane fizycznie zmierzone

clear all; close all;

dane_meteo = [
2016, 3, 21, 19, 2, 6.280000, 0.700000, 1015.280029, 0.250000, 0.650000, 8427.500000;
2016, 3, 21, 20, 2, 5.800000, 0.730000, 1015.650024, 0.430000, 0.750000, 8080.000000;
2016, 3, 21, 21, 2, 5.560000, 0.750000, 1015.960022, 0.350000, 0.750000, 7618.500000;
2016, 3, 21, 22, 2, 5.390000, 0.750000, 1016.169983, 0.240000, 0.750000, 7043.250000;
2016, 3, 21, 23, 2, 4.870000, 0.780000, 1016.270020, 0.300000, 0.590000, 6436.750000;
2016, 3, 22, 0, 3, 4.800000, 0.780000, 1016.250000, 0.190000, 0.580000, 6092.750000;
2016, 3, 22, 1, 3, 4.640000, 0.790000, 1016.179993, 0.290000, 0.580000, 5972.250000;
2016, 3, 22, 2, 3, 4.410000, 0.800000, 1016.080017, 0.180000, 0.590000, 6006.250000;
2016, 3, 22, 3, 3, 4.290000, 0.800000, 1016.000000, 0.150000, 0.600000, 6434.500000;
2016, 3, 22, 4, 3, 3.760000, 0.810000, 1015.979980, 0.030000, 0.610000, 6900.750000;
2016, 3, 22, 5, 3, 3.640000, 0.810000, 1016.010010, 0.090000, 0.630000, 7824.250000;
2016, 3, 22, 6, 3, 3.720000, 0.820000, 1016.070007, 0.040000, 0.750000, 8584.750000;
2016, 3, 22, 7, 3, 4.220000, 0.820000, 1016.130005, 0.080000, 0.750000, 8742.250000;
2016, 3, 22, 8, 3, 5.610000, 0.770000, 1016.130005, 0.580000, 0.750000, 8916.250000;
2016, 3, 22, 9, 3, 6.470000, 0.720000, 1016.039978, 0.740000, 0.750000, 9217.750000;
2016, 3, 22, 10, 3, 7.590000, 0.650000, 1015.830017, 0.980000, 0.750000, 9475.000000;
2016, 3, 22, 11, 3, 8.990000, 0.580000, 1015.530029, 0.560000, 0.440000, 9305.250000;
2016, 3, 22, 12, 3, 8.830000, 0.520000, 1015.179993, 0.800000, 0.440000, 8997.500000;
2016, 3, 22, 13, 3, 9.470000, 0.490000, 1014.820007, 0.830000, 0.440000, 8827.500000;
2016, 3, 22, 14, 3, 9.880000, 0.460000, 1014.530029, 0.900000, 0.440000, 8624.000000;
2016, 3, 22, 15, 3, 9.820000, 0.460000, 1014.369995, 0.730000, 0.690000, 8380.500000;
2016, 3, 22, 16, 3, 9.060000, 0.480000, 1014.369995, 1.010000, 0.750000, 8264.000000;
2016, 3, 22, 17, 3, 8.700000, 0.500000, 1014.530029, 0.760000, 0.750000, 8375.500000;
2016, 3, 22, 18, 3, 7.590000, 0.570000, 1014.820007, 0.430000, 0.670000, 8815.000000;
2016, 3, 22, 19, 3, 6.310000, 0.620000, 1015.179993, 0.200000, 0.650000, 8423.500000 ];

[l_pom,k] = size(dane_meteo);
t_pom = 1:l_pom;
y_pom = dane_meteo(:,6)';   % w 6. kolumnie s� pomiaty temperatury

t = 1:0.1:l_pom;                  % wektor odci�tych dla rysowania funkcji aproksymuj�cej

n_max = 15;                       % arbitralnie wybrany maksymalny stopien wielomianu
for n = 1:n_max,
  p = polyfit(t_pom,y_pom,n);     % p - wsp�czynniki wielomianu
  y_apr = polyval(p,t_pom);       % wartosci funkcji aproksymuj�cej
  dy = y_apr-y_pom;  % b��d aproksymacji danych
  err(n) = sqrt((dy*dy')/l_pom);  % miara b��du 
  stopien_wielomianu = n,
  RMSE = err(n),
  plot(t_pom,y_pom,'r.',t,polyval(p,t)), 
  disp('Aby przej�� do aproksymancji kolejnym wielomianem - Naci�nij ENTER');
  if n<n_max, pause,  end
end
RMSE = err,

