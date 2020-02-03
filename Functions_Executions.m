function [output1,output2] = Functions_Executions(t,dt,const,dynamics)
v0=const(3);
u0=const(2)*v0;
f0=[v0,u0];
if length(const)==5
    fun=@Izhikevich_Neuron_model;
elseif length(const)==6
    fun=@Izhikevich_Neuron_model_with_noise;
end
add_func=@After_spike_reset;

[f,dfdt]=RungeKutta(t,dt,f0,const,fun,add_func);
if length(const)==5
    if dynamics == 1
        Visualization(f(:,1),f(:,2),"t, ms","v(t)","Regular Spiking",[0 t],[-100 35],["proverka_4","proverka_5"]);  
    elseif dynamics == 2
        Visualization(f(:,1),f(:,2),"t, ms","v(t)","Intrinsically bursting",[0 t],[-100 35],["proverka_4","proverka_5"]);
    elseif dynamics == 3
        Visualization(f(:,1),f(:,2),"t, ms","v(t)","Chattering",[0 t],[-100 35],["proverka_4","proverka_5"]);
    elseif dynamics == 4
        Visualization(f(:,1),f(:,2),"t, ms","v(t)","Fast Spiking",[0 t],[-100 35],["proverka_4","proverka_5"]);  
    elseif dynamics == 5
        Visualization(f(:,1),f(:,2),"t, ms","v(t)","Low-threshold spiking",[0 t],[-100 35],["proverka_4","proverka_5"]);
    elseif dynamics == 6
        Visualization(f(:,1),f(:,2),"t, ms","v(t)","Thalamo-cortical",[0 t],[-100 35],["proverka_4","proverka_5"]);
    elseif dynamics == 7
        Visualization(f(:,1),f(:,2),"t, ms","v(t)","Rezonator",[0 t],[-100 35],["proverka_4","proverka_5"]);
    end
elseif length(const)==6
    [f_n,dfdt_n]=RungeKutta(t,dt,f0,const,@Izhikevich_Neuron_model,add_func);    
    if dynamics == 1
        Visualization(f(:,1),[f(:,2),f_n(:,2)],"t, ms","v(t)","Regular Spiking",[0 t],[-100 35],["With noise","Without noise"]);
        Visualization([f(:,2),f_n(:,2)],[f(:,3),f_n(:,3)],"v(t)","u(t)","Regular Spiking",[],[],["With noise","Without noise"]);
    elseif dynamics == 2
        Visualization(f(:,1),[f(:,2),f_n(:,2)],"t, ms","v(t)","Intrinsically bursting",[0 t],[-100 35],["With noise","Without noise"]);
        Visualization([f(:,2),f_n(:,2)],[f(:,3),f_n(:,3)],"v(t)","u(t)","Intrinsically bursting",[],[],["With noise","Without noise"]);
    elseif dynamics == 3
        Visualization(f(:,1),[f(:,2),f_n(:,2)],"t, ms","v(t)","Chattering",[0 t],[-100 35],["With noise","Without noise"]);
        Visualization([f(:,2),f_n(:,2)],[f(:,3),f_n(:,3)],"v(t)","u(t)","Chattering",[],[],["With noise","Without noise"]);
    elseif dynamics == 4
        Visualization(f(:,1),[f(:,2),f_n(:,2)],"t, ms","v(t)","Fast Spiking",[0 t],[-100 35],["With noise","Without noise"]);
        Visualization([f(:,2),f_n(:,2)],[f(:,3),f_n(:,3)],"v(t)","u(t)","Fast Spiking",[],[],["With noise","Without noise"]);
    elseif dynamics == 5
        Visualization(f(:,1),[f(:,2),f_n(:,2)],"t, ms","v(t)","Low-threshold spiking",[0 t],[-100 35],["With noise","Without noise"]);
        Visualization([f(:,2),f_n(:,2)],[f(:,3),f_n(:,3)],"v(t)","u(t)","Low-threshold spiking",[],[],["With noise","Without noise"]);
    elseif dynamics == 6
        Visualization(f(:,1),[f(:,2),f_n(:,2)],"t, ms","v(t)","Thalamo-cortical",[0 t],[-100 35],["With noise","Without noise"]);
        Visualization([f(:,2),f_n(:,2)],[f(:,3),f_n(:,3)],"v(t)","u(t)","Thalamo-cortical",[],[],["With noise","Without noise"]);
    elseif dynamics == 7      
        Visualization(f(:,1),[f(:,2),f_n(:,2)],"t, ms","v(t)","Rezonator",[0 t],[-100 35],["With noise","Without noise"]);
        Visualization([f(:,2),f_n(:,2)],[f(:,3),f_n(:,3)],"v(t)","u(t)","Rezonator",[],[],["With noise","Without noise"]);
    end
    
    
end

output1 = f;
output2 = dfdt;
end

