function [f,dfdt]=RungeKutta(t,dt,f0,const,fun,add_func)
% t - integration time
% dt - time step for integration
% f0 - mean of function in zero time step
% const - constant values for the function to be integrated
% fun - function to be integrated. Requirement form for the function:
%       [double 1xN]=fun(t,f,const)
n=round(t/dt);
m=max(size(f0));
f=zeros(n,m+1);
dfdt=zeros(n,m+1);
f(1,1:m+1)=[0,f0];
t_i=0;
f_i=f0;
if length(const)>5
    D=const(6);
    noise=wgn(n,round(m/2),0);
end
for i=2:n
    k1=dt*fun(t,f(i-1,2:m+1),const);
    k2=dt*fun(t+dt/2,f(i-1,2:m+1)+k1,const);
    k3=dt*fun(t+dt/2,f(i-1,2:m+1)+k2,const);
    k4=dt*fun(t+dt,f(i-1,2:m+1)+k3,const);
    t_i=t_i+dt;
    dfdt_i=1/6*(k1+2*k2+2*k3+k4);
    if length(const)>5
       a=dfdt_i(1:2:m);
       b=noise(i,:);
       dfdt_i(1:2:m)=dfdt_i(1:2:m)+D*noise(i,:);
    end
    f_i=f_i+dfdt_i;
    f_i=add_func(t,f_i,const);
    f(i,1:m+1)=[t_i,f_i];
    dfdt(i,1:m+1)=[t_i,dfdt_i];
end
end