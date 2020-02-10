function [f,dfdt] = Functions_Executions(t,dt,const,dynamics,task)
v0=const(3);
u0=const(2)*v0;
f0=[v0,u0];

if task==1
    fun=@Izhikevich_Neuron_model;
    add_func=@After_spike_reset;
    [f,dfdt]=RungeKutta(t,dt,f0,const,fun,add_func);
    Visualization(f(:,1),f(:,2),"t, ms","v(t), mV",dynamics+". Membrane potential versus time.",[0 t],[-100 35],[]);
%     Visualization(f(:,1),f(:,2),"t, ms","v(t), mV",dynamics+". Membrane potential versus time.",[],[],[]);
elseif task==2
    c=const(1);
    d=const(2);
    I=const(3);
    k=const(4);
    amax=const(5);
    bmax=const(6);
    
    disp_t=0.005;
    [A,B,f] = Regimemap(c,d,I,k,disp_t,amax,bmax);
    dfdt=[A;B];
elseif task==3
    fun=@Izhikevich_Neuron_model_with_noise;
    add_func=@After_spike_reset;
    [f,dfdt]=RungeKutta(t,dt,f0,const,fun,add_func);
    [f_n,dfdt_n]=RungeKutta(t,dt,f0,const,@Izhikevich_Neuron_model,add_func);
     Visualization(f(:,1),[f(:,2),f_n(:,2)],"t, ms","v(t), mV",dynamics+". Membrane potential versus time.",[0 t],[-100 35],["With noise","Without noise"]);
     Visualization([f(:,2),f_n(:,2)],[f(:,3),f_n(:,3)],"v(t), mV","u(t), mV",dynamics+". Phase portrait.",[],[],["With noise","Without noise"]);   
elseif task==4
    n=const(8);
    for i=2:n
        f0=[f0,[v0,u0].*(1-0.1*rand(1,2))];
    end
    fun=@Izhikevich_Neuron_model_with_coupling;
    add_func=@After_spike_reset;
    [f,dfdt]=RungeKutta(t,dt,f0,const,fun,add_func);
     Visualization(f(:,1),[f(:,2),f(:,4)],"t, ms","v(t), mV","Two coupling neurons. "+dynamics+". Membrane potential versus time.",[0 t],[-100 35],["First neuron","Second neuron"]);
     Visualization([f(:,2),f(:,4)],[f(:,3),f(:,5)],"v(t), mV","u(t), mV","Two coupling neurons. "+". Phase portrait.",[],[],["First neuron","Second neuron"]);   
elseif task==5
    n=const(8);
    max_tau=const(9);
    dtau=const(10);
    for i=2:n
        f0=[f0,[v0,u0].*(1-0.1*rand(1,2))];
    end
    fun=@Izhikevich_Neuron_model_with_coupling;
    add_func=@After_spike_reset;
    [f,dfdt]=RungeKutta(t,dt,f0,const,fun,add_func);
    y=mean(f(:,2:2:2*n)')';
    Visualization(f(:,1),f(:,2:2:2*n),"t, ms","v(t)","Coupling N neurons."+dynamics+". Membrane potential versus time.",[],[],[]);
    plot(f(:,1),y,":r","LineWidth",3)
    [C,tau,tau_c]=Autocorrelation_function(y,dt,t,max_tau,dtau);
   Visualization(tau,C,"\tau, ms","C","Autocorrelation function",[],[],[]);
end
end

