clear;
close all;
syms x;

h = logspace (3,15);
f(x) =  (x.^2+1).^(1/2) - x;
fp(x) =   x./((x.^2 + 1).^(1/2)) - 1;

fpp = diff(f,x);

fp(5)
loglog(h,fpp(h),h,fp(h))

%%
clear;
syms x;
f1 = (x^2 + 1)^(1/2) - x;
f2 = 1/((x^2 +1)^(1/2) + x);
pochodna1 = diff(f1,x)
pochodna2 = diff(f2,x)
roznica = pochodna1 - pochodna2
simplify(roznica)
 %x:= Domain::Interval([-1],[1]);