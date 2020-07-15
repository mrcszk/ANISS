% B³¹d ilorazu ró¿nicowego pierwszego rzêdu z krokiem rzeczywistym.
clear;
close all;

f = @(x) x.^3 + 5*x;
fp = @(x) 3*x.^2 + 5;

x0 = 1;

h = logspace (-20,0,100);
ir1 = (f(x0 + h) - f(x0)) ./ h;
bw = abs((ir1 - fp(x0)) / fp(x0));

loglog(h, abs(bw), 'o');
