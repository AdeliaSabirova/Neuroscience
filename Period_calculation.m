function [T] = Period_calculation(f0,const)
t=3000;
dt=0.001;
c=const(3);

fun=@Izhikevich_Neuron_model;
add_func=@After_spike_reset;

[full_f,dfdt]=RungeKutta(t,dt,f0,const,fun,add_func);

f=full_f(300/dt:length(full_f),:);

N = 0;
for i = 1:length(f)
    if f(i,2)==c
        N=N+1;
    end
end

if N==0 || N==1 || N==2
    T=0;
else
   time = zeros(N,1);
    j=1;
    for i = 1:length(f)
        if f(i,2)==c
            time(j)=f(i,1);
            j=j+1;
        end
    end
    T = zeros(N-1,1);
    for i = 1:N-1
        T(i) = time(i+1)-time(i);
    end 
end
end

