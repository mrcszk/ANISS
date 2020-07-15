% B³¹d ilorazu ró¿nicowego z krokiem urojonym.

clear;
close all;

f = @(x) x.^3 + 5*x;
fp = @(x) 3*x.^2 + 5;

x0 = 1;

h = logspace (-20,0,100);
ir1 = (f(x0 + h) - f(x0)) ./ h;
ir2 = (f(x0 + h) - f(x0 - h)) ./ (2*h);
ir3 = imag(f(x0 + 1i * h)) ./ h;

bw = abs((ir1 - fp(x0)) / fp(x0));
bw2 = abs((ir2 - fp(x0)) / fp(x0));
bw3 = abs((fp(x0) - ir3)) / fp(x0);

loglog(h,bw,'o',h,bw2,'x',h,bw3,'p')