function dfdt = Izhikevich_Neuron_model(t,f,const)
    a=const(1);
    b=const(2);
    if const(5)==0
        I=5*rand;
    else
        I=const(5); 
    end
    v=f(1);
    u=f(2);
    dv=0.04*v^2+5*v+140-u+I;
    du=a*(b*v-u);
    
    dfdt=[dv,du];
end