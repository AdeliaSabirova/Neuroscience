function [C,tau,tau_c]=Autocorrelation_function(y,dt,t,max_tau,steps_tau)
y_mean=mean(y);
y_=y-y_mean;
if max_tau==t
    tau=0:max_tau/steps_tau:max_tau-max_tau/steps_tau;
elseif max_tau>t
    tau=0:t/steps_tau:t-t/steps_tau;
else
    tau=0:max_tau/steps_tau:max_tau;
end
tau=tau';
shift=round(tau/dt);
C=zeros(size(tau));

y_2=mean(y_.^2);
for i=1:length(tau)
    shift_i=shift(i);
    y_t=y_(1:length(y)-shift_i);
    y_ttau=y_(1+shift_i:length(y));
    y_res=y_t.*y_ttau;
    C(i)=mean(y_res)/y_2;
end
tau_c=sum(C);
end