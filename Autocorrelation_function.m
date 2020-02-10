function [C,tau,tau_c]=Autocorrelation_function(y,dt,t,max_tau,dtau)
y_mean=mean(y);
y_=y-y_mean;
start_time=0;
start=1+start_time/dt;
if max_tau<t/2-start_time
    tau=0:dtau:max_tau;
else
    tau=0:dtau:t/2-start_time-dtau;
    max_tau=t/2-start_time;
end
tau=tau';
shift=round(tau/dt);
C=zeros(size(tau));
max_size=round(max_tau/dt);
for i=1:length(tau)
    shift_i=shift(i);
    y_t=y_(start:start+max_size);
    y_ttau=y_(start+shift_i:start+max_size+shift_i);
    R = corrcoef(y_t,y_ttau);
    C(i)=R(1,2);
end
tau_c=sum(C.^2);
end