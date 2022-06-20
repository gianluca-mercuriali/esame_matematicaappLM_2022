 
function [a,Profit_greedy,mx] = randGreedy(memory,Profit,Np,T )
%% greedy brutale --> prendiamo elmenti del set dei processi e li mettiamo    
% Original Author: Mercuriali Gianluca mt.1056381

mx=0;
temp_m = memory; %vettore temporaneo di memory
temp_p = Profit;

a = zeros(1, Np); %vettore zeri, che conterrà i processi allocati casualmente
b = zeros (1, Np); % vettore zeri che conterrà il profitto greedy
k=1;


while  1
        
    i = randi([1,length(temp_m)],1);
    
    if( mx + temp_m(i) > T)
        break
    else
        
    mx= mx + temp_m(i);
    a(k) = temp_m(i);
    b(k) = temp_p(i);
    
    temp_m(i)=[];
    temp_p(i) =[];
    
    k=k+1;  
    end
    
    if (length(temp_m)==0) %
        break
    end
    
end

Profit_greedy = b;
return 

