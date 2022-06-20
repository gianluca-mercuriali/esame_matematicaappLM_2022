function [a,b,tx] = MaxGreedy(time,Profit,Np,T)

tx=0;
temp_t = sort(time, 'descend'); %vettore temporaneo di time
temp_p = sort(Profit, 'descend');
a = zeros(1, Np); %vettore zeri, che conterrà i processi allocati casualmente
b = zeros (1, Np); % vettore zeri che conterrà il profitto greedy
k=1;

while  1
    
    i=1;
    if( tx + temp_t(i) > T)
        break
    else
        
    tx= tx + temp_t(i);
    a(k) = temp_t(i);
    b(k) = temp_p(i);
  
    
    i=i+1;
    k=k+1;  
    end
    
end


return 