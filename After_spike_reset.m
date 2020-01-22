function f_after = After_spike_reset(t,f,const)
    c=const(3);
    d=const(4);
    v=f(1);
    u=f(2);
    if v>=30
        v=c;
        u=u+d;
    end
    f_after=[v,u];
end