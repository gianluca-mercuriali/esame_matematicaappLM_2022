clc
clear all

T = 10; %tempo (asse x)
M = 20; %memoria (asse Y)
Np=8; % numero di processi

time= [4,5,5,3,5,3,1,1]
memory=[5,3,3,4,2,2,4,1]
Profitto_totale = 0;
Profit = time.*memory; %profitto dato da tutti i porcessi generati

tx = 0; %sommatoria tempo dello scaffale corrente
%mx = 0; %sommatoria memoria
%A_scaffale = T*(M/4); %area di ciascun scaffale
% temp_t = time; %vettore temporaneo dei tempi
% temp_m = memory; %vettore temporaneo delle memorie

t = zeros(1, Np); %vettore zeri che conterrà i tempi allocati dello scaffale corrente
m = zeros (1, Np); % vettore zeri che conterrà le memorie allocate dello scaffale corrente
matrix_t = zeros (4,Np);
matrix_m = zeros (4,Np);
soluz_t= zeros(1,Np);
soluz_m = zeros (1,Np);
k=1;
x=1;
d=4;

%% GREEDY

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

temp_t=t_decrescente; 
temp_m=m_decrescente;
scarto_t=t_decrescente;
scarto_m=m_decrescente;
                

for j = 1:4 %ciclo che scorre i 4 scaffali (ho diviso area totale in 4 scaffali)
   
    %indice delle righe
    for i = 1 : Np %ciclo che mi riempie lo scaffale corrente fino a saturare i tempi
                
        if(temp_m(i) <= M/4) %controllo che verifica che la memoria dell'i-esimo elemento sia inferiore a quella massima contenibile nello scaffale (potrebbe non servire se generiamo memorie dei processi che non superino mai questo limite)
            
            if( tx + temp_t(i) > T) %condizione che controlla che non si oltrepassi il limite massimo dei tempi
                break
            else
                tx = tx + temp_t(i); %somma dei tempi che metto nello scaffale corrente
                t(k) = temp_t(i); %tempi che metto nello scaffale
                m(k) = temp_m(i); %memorie che metto nello scaffale
                scarto_t(x)=[]
                scarto_m(x)=[]

               
                k=k+1;
                x=x+1;
            end
           
        end
        
    end
    
    
    matrix_t(d,:) = t;
    matrix_m(d,:) = m;
    Profitto_scaffale = sum(t.*m);
    Profitto_totale = Profitto_totale + Profitto_scaffale;
    t = zeros(1, Np);%azzero tutti gli elementi per lo scaffale successivo
    m = zeros(1, Np);%azzero tutti gli elementi per lo scaffale successivo
    k=1; %resetto il contatore degli indici
    tx=0; %azzero la somma dei tempi
    d=d-1;
    
    
end

Profitto_totale;


scarto_t
scarto_m
Profit_scarto = scarto_t .* scarto_m
Profit_sol = matrix_t .* matrix_m

matrix_t
matrix_m