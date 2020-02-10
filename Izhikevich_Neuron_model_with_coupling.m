function dfdt = Izhikevich_Neuron_model_with_coupling(t,f,const)
    a=const(1);
    b=const(2);
    if const(5)==0
        I=5*rand;
    else
        I=const(5); 
    end
    D=const(6);
    w=const(7);
    dfdt=zeros(size(f));
    for i=1:2:length(f)
        v=f(i);
        u=f(i+1);
        
        coupling=0;
        for j=1:2:length(f)
            if i~=j
                vj=f(j);
                coupling=coupling+w*(vj-v);
            end
        end
        
        dv=0.04*v^2+5*v+140-u+I+coupling;
        du=a*(b*v-u);
        
        dfdt(i)=dv;
        dfdt(i+1)=du;
    end
end