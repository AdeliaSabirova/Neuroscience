function [C,tau,tau_c]=Autocorrelation_function(y,dt,t,max_tau,dtau)
y_mean=mean(y);
y_=y-y_mean;
% if max_tau==t
%     tau=0:max_tau/steps_tau:max_tau-max_tau/steps_tau;
% elseif max_tau>t
%     tau=0:t/steps_tau:t-t/steps_tau;
% else
%     tau=0:max_tau/steps_tau:max_tau;
% end
tau=0:dtau:max_tau;
tau=tau';
shift=round(tau/dt);
C=zeros(size(tau));

max_size=round(max_tau/dt);
y_2=mean(y_(1:max_size).^2);
for i=1:length(tau)
    shift_i=shift(i);
    y_t=y_(1:max_size-shift_i);
    y_ttau=y_(1+shift_i:max_size);
    y_res=y_t.*y_ttau;
    C(i)=mean(y_res)/y_2;
end
tau_c=sum(C);
end