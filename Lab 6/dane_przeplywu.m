% 4. Problem wyboru klasy funkcji aproksymuj¹cej

clear all, close all,

% Dane pomiarowe przep³ywu wody w Rabie
q = [2.40  2.56   2.56  2.56  2.72  2.88  3.20  4.04  5.56  6.20  9.30 14.70 ...
    18.20 21.80  27.80 30.20 31.40 30.20 29.00 27.80 25.40 24.20 23.00 21.80 ...
    21.80 20.60  19.40 19.40 18.20 17.00 17.00 15.90 14.70 14.70 13.50 13.50 ...
    12.30 12.30  11.10 11.10 10.50 10.50 10.50  9.90  9.90  9.90  9.30  9.30 ...
     9.30  8.70   8.70  8.70  8.70  8.70  8.10  8.10  8.10  8.10  7.34  6.96 ...
     6.96  6.96   6.96  6.96  6.58  7.34  6.96  6.96  6.96];
t = 1:length(q);

% dane fazy opadania stanu wody
t_spadek = t(18:end);  q_spadek =q(18:end);

plot(t, q, 'k.',t_spadek,q_spadek,'ro')
xlabel('t'), ylabel('q'), 
title('Przebieg fali wezbraniowej');
legend('wszystkie dane', 'faza opadania stanu wody'),

