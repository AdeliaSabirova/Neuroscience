function f_after = After_spike_reset(t,f,const)
    c=const(3);
    d=const(4);
    f_after=zeros(size(f));
    for i=1:2:length(f)
        v=f(i);
        u=f(i+1);
        if v>=30
            v=c;
            u=u+d;
        end
    f_after(i)=v;
    f_after(i+1)=u;
    end
end