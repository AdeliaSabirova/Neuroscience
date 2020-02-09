function []=Visualization(x,y,xname,yname,titlename,xlim_value,ylim_value,legenda)
figure();
[a,b]=size(y);
[c,d]=size(x);
if b==1
    plot(x,y,'r')
else
    hold on
    for i=1:b
        if d==b
            plot(x(:,i),y(:,i))
        else
            plot(x,y(:,i))
        end
    end
    if ~isempty(legenda)
        legend(legenda)
    end
end
title(titlename)
xlabel(xname)
ylabel(yname)
grid on
if ~isempty(xlim_value) && ~isempty(ylim_value)
    xlim(xlim_value)
    ylim(ylim_value) 
end
end