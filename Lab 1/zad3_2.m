clear;
close all;

x0 = 1;
M = 12;   
D = zeros(M,M);  

%h = logspace (-20,0,100);
h = 1;

ir1 = (sin(x0 + h) - sin(x0)) ./ h;
ir2 = (sin(x0 + h) - sin(x0 - h)) ./ (2*h);

bw = abs((ir1 - cos(x0)) / cos(x0));
bw2 = abs((ir2 - cos(x0)) / cos(x0));
 
%loglog(h,bw,'o',h,bw2,'x')


 thn = zeros(M+1,1); tbw = zeros(M+1,1);
 for n = 1 : M                  
   hn = h/2^(n-1);
   thn(n) = hn;              
   D(n,1) = ( sin(x0+hn) - sin(x0-hn) ) / (2*hn); 
 end
 for k = 2 : M
   for n = k : M
     D(n,k) = D(n,k-1) + ( D(n,k-1) - D(n-1,k-1) ) / (4^(k-1) - 1 );
   end
 end
 tbw = bw2;
  for n = 1 : M           
    tbw(n+1) = abs((D(n,n) - cos(x0)) / cos(x0));
  end
    disp(thn)
    disp(tbw)