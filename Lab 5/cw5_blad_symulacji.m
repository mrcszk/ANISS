function [J_1, J_2, J_inf] = cw5_blad_symulacji(k),
% Obliczanie b³êdów symulacji obliczanych wg 3 norm

% Argumentem wejœciowym jest parametr $k modelu.
% Argumenty wyjœciowe to obliczone b³êdy 

  ti = [0,    7.05, 14.24, 21.95, 30.00, 38.32, 47.08, 56.46, 66.89, 78.72, 90.65, 104.58, 113.64, 123.07, 135.75 ];
  hi = [0.13, 0.12,  0.11,  0.10,  0.09,  0.08,  0.07,  0.06,  0.05,  0.04,  0.03,   0.02,   0.015,  0.01,   0.005];
  h0 = hi(1); 
  xi = sqrt(h0)-sqrt(hi);
  yi = ti; 
  c = 2/k;

  delta2 = (yi - c*xi);
  J = delta2*delta2'/length(xi);

  J_1 = sum(abs(yi - c*xi))/length(xi);
  J_2 = sqrt(J);
  J_inf = max(abs(yi - c*xi));
end

  
