function [a] = u(x,t,N,alpha)
 
a = 0;
for k = 0:N
wk = (2*k+1)*pi;
a = a + 4/(alpha*wk^3)*sin(wk*x)*exp(-alpha*wk^2*t);
end
end
