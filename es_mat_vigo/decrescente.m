clc
clear all
Np=5;
time = randi([1,5],1,Np) %vettore dei tempi
memory = randi([1,5],1,Np) %vettore delle memorie
profitto = time.*memory
t_decrescente = time;
m_decrescente = memory;



for i =1:Np-1
    for j=i+1:Np
       
        
        if(t_decrescente(i)*m_decrescente(i) <= t_decrescente(j)*m_decrescente(j))
            
            tmp_t = t_decrescente(i);
            tmp_m = m_decrescente(i);
            t_decrescente(i) = t_decrescente(j);
            m_decrescente(i) = m_decrescente(j);
            t_decrescente(j) = tmp_t;
            m_decrescente(j) = tmp_m;
            
        end
    end
end



t_decrescente
m_decrescente
profittoDecrescente= t_decrescente.*m_decrescente