clear;
close all;

f = @(x) x.^3 + 5*x;
fp = @(x) 3*x.^2 + 5;

x0 = 1;
M = 8;   
D = zeros(M,M);  

h = logspace (-20,0,100);

ir1 = (f(x0 + h) - f(x0)) ./ h;
ir2 = (f(x0 + h) - f(x0 - h)) ./ (2*h);

bw = abs((ir1 - fp(x0)) / fp(x0));
bw2 = abs((ir2 - fp(x0)) / fp(x0));
 
loglog(h,bw,'o',h,bw2,'x')

% Ekstrapolacja Richardsona
 for n = 1 : M                  
   hn = h/2^(n-1);              
   D(n,1) = ( f(x0+hn) - f(x0-hn) ) / (2*hn); 
 end
 for k = 2 : M
   for n = k : M
     D(n,k) = D(n,k-1) + ( D(n,k-1) - D(n-1,k-1) ) / (4^(k-1) - 1 );
   end
 end
 
  for n = 1 : M        
    hold on
    bw = abs((D(n) - fp(x0)) / fp(x0));
    loglog(h,bw,'p')
  end
  