function [A,B,out] = Regimemap(c,d,I,k,disp_t,amax,bmax)
a = 0:amax/k:amax;
b = 0:bmax/k:bmax;

[A,B] = meshgrid(a,b);
[m,n]=size(A);
out=zeros(size(A));
for i=1:m
    for j=1:n
        const=[A(i,j),B(i,j),c,d,I];
        
        v0=c;
        u0=B(i,j)*v0;
        f0=[v0,u0];
        T = Period_calculation_mex(f0,const);
        
        if T==0
            m=0;
        else
            n_bins=round((max(T)-min(T))/disp_t*4);            
            if n_bins<5
                m=1;
            else
                [N,bins] = histcounts(T,n_bins);
                m=length(findpeaks([0,N,0])); 
                if m>9
                    m=9;
                end
            end
        end
        out(i,j)=m;
    end
end
figure()
contourf(A,B,out)
title("Bifurcation of periodic points")
xlabel("a")
ylabel("b")
end

