 
function [a,b,tx] = randGreedy(time,Profit,Np,T )
%% rand_T_M è una funzione che mi genera M e T casuale    
% Original Author: Mercuriali Gianluca mt.1056381
% Date and version 31/03/2022

tx=0;
temp_t = time; %vettore temporaneo di time
temp_p = Profit;

a = zeros(1, Np); %vettore zeri, che conterrà i processi allocati casualmente
b = zeros (1, Np); % vettore zeri che conterrà il profitto greedy
k=1;


while  1
        
    i = randi([1,length(temp_t)],1);
    
    if( tx + temp_t(i) > T)
        break
    else
        
    tx= tx + temp_t(i);
    a(k) = temp_t(i);
    b(k) = temp_p(i);
    
    temp_t(i)=[];
    temp_p(i) =[];
    
    k=k+1;  
    end
    
    if (length(temp_t)==0) %
        break
    end
    
end


return 

