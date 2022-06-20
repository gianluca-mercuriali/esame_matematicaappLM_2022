clc
clear all

T = 10; %tempo (asse x)
M = 20; %memoria (asse Y)
Np=40; % numero di processi

time = randi([1 5],1,Np) %vettore dei tempi
memory = randi([1 5],1,Np) %vettore delle memorie
Profitto_totale = 0;
Profit = time.*memory; %profitto dato da tutti i porcessi generati

tx = 0; %sommatoria tempo dello scaffale corrente
%mx = 0; %sommatoria memoria
%A_scaffale = T*(M/4); %area di ciascun scaffale
temp_t = time; %vettore temporaneo dei tempi
temp_m = memory; %vettore temporaneo delle memorie

t = zeros(1, Np); %vettore zeri che conterrà i tempi allocati casualmente dello scaffale corrente
m = zeros (1, Np); % vettore zeri che conterrà le memorie allocate casualmente dello scaffale corrente
matrix_t = zeros (4,Np);
matrix_m = zeros (4,Np);
soluz_t= zeros(1,Np);
soluz_m = zeros (1,Np);
k=1;
x=1;
d=4;

%% GREEDY

for j = 1:4 %ciclo che scorre i 4 scaffali (ho diviso area totale in 4 scaffali)
    
    %indice delle righe
    while  1 %ciclo che mi riempie lo scaffale corrente fino a saturare i tempi
        
        i = randi(length(temp_t)); %prendo un indice casuale del vettore temporaneo dei tempi
        
        if(temp_m(i) <= M/4) %controllo che verifica che la memoria dell'i-esimo elemento sia inferiore a quella massima contenibile nello scaffale (potrebbe non servire se generiamo memorie dei processi che non superino mai questo limite)
            
            if( tx + temp_t(i) > T) %condizione che controlla che non si oltrepassi il limite massimo dei tempi
                break
            else
                tx = tx + temp_t(i); %somma dei tempi che metto nello scaffale corrente
                t(k) = temp_t(i); %tempi che metto nello scaffale
                m(k) = temp_m(i); %memorie che metto nello scaffale
                soluz_t(x)= t(k); %vettore soluzione tempi
                soluz_m(x)= m(k); %vettore soluzione memorie
                temp_t(i)=[]; %rimuovo il contenuto i-esimo del vettore temporaneo dei tempi
                temp_m(i) =[]; %rimuovo il contenuto i-esimo del vettore temporaneo delle memorie
                
                
                k=k+1;
                x=x+1;
            end
            
        else %se entra qui significa che l'i-esima memoria è maggiore di quella massima contenibile nello scaffale
            temp_t(i)=[]; %rimuovo il contenuto i-esimo del vettore temporaneo dei tempi
            temp_m(i) =[]; %rimuovo il contenuto i-esimo del vettore temporaneo delle memorie
        end
        if (isempty(temp_t)) %condizione che termina il while se vengono presi tutti gli elementi del vettore tempo (potrebbe non servire nel programma finale)
            break
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
    
    if(isempty(temp_m) || isempty(temp_t)) %potrebbe non servire se uso Np grande
        break
    end
end

Profitto_totale;
% soluz_t;
%soluz_m

scarto_t=temp_t
scarto_m=temp_m
Profit_scarto = scarto_t .* scarto_m
Profit_sol = matrix_t .* matrix_m

matrix_t
matrix_m

%% LOCAL SEARCH first improvement 

matrix_t_ls = matrix_t;
matrix_m_ls = matrix_m;
scarto_t_ls=scarto_t;
scarto_m_ls=scarto_m;
temp_matrix_t_ls = matrix_t_ls;
temp_matrix_m_ls = matrix_m_ls;
temp_scarto_t_ls = scarto_t_ls; 
temp_scarto_m_ls = scarto_m_ls;
Profit_scarto_ls=Profit_scarto;

for d = 4: -1 : 1 %d-esima riga
    for j = 1:Np %j-esima colonna
        
        
        for k = 1: length(scarto_t_ls)
            
            if ( Profit_sol(d,j) < Profit_scarto_ls(k))
                
                temp_matrix_t_ls(d,j) = scarto_t_ls(k);
                temp_matrix_m_ls(d,j) = scarto_m_ls(k);
                temp_scarto_t_ls(k) = matrix_t_ls(d,j);
                temp_scarto_m_ls(k) = matrix_m_ls(d,j);
                
                if ( sum(temp_matrix_t_ls(d,:)) > 10 )
                    
                    temp_scarto_t_ls(k)= scarto_t_ls(k);
                    temp_scarto_m_ls(k)= scarto_m_ls(k);
                    temp_matrix_t_ls(d,j) = matrix_t_ls(d,j);
                    temp_matrix_m_ls(d,j) = matrix_m_ls(d,j);
                    
                else
                    
                    scarto_t_ls(k)= temp_scarto_t_ls(k);
                    scarto_m_ls(k)= temp_scarto_m_ls(k);
                    matrix_t_ls(d,j)=temp_matrix_t_ls(d,j);
                    matrix_m_ls(d,j)=temp_matrix_m_ls(d,j);
                    Profit_scarto_ls = scarto_t_ls .* scarto_m_ls;
                    break
                end
                
            end
            
        end
    end
end


matrix_t_ls;
matrix_m_ls;
Profit_ls = matrix_t_ls.*matrix_m_ls

%% LOCAL SEARCH best improvement


matrix_t_bi = matrix_t;
matrix_m_bi = matrix_m;
scarto_t_bi=scarto_t;
scarto_m_bi=scarto_m;
temp_matrix_t_bi = matrix_t_bi;
temp_matrix_m_bi = matrix_m_bi;
temp_scarto_t_bi = scarto_t_bi; 
temp_scarto_m_bi = scarto_m_bi;
Profit_scarto_bi=Profit_scarto;

for d = 4: -1 : 1 %d-esima riga
    for j = 1:Np %j-esima colonna
        
        
        for k = 1: length(scarto_t_bi)
            
            if ( Profit_sol(d,j) < Profit_scarto_bi(k))
                
                temp_matrix_t_bi(d,j) = scarto_t_bi(k);
                temp_matrix_m_bi(d,j) = scarto_m_bi(k);
                temp_scarto_t_bi(k) = matrix_t_bi(d,j);
                temp_scarto_m_bi(k) = matrix_m_bi(d,j);
                
                if ( sum(temp_matrix_t_bi(d,:)) > 10 )
                    
                    temp_scarto_t_bi(k)= scarto_t_bi(k);
                    temp_scarto_m_bi(k)= scarto_m_bi(k);
                    temp_matrix_t_bi(d,j) = matrix_t_bi(d,j);
                    temp_matrix_m_bi(d,j) = matrix_m_bi(d,j);
                    
                else
                    
                    scarto_t_bi(k)= temp_scarto_t_bi(k);
                    scarto_m_bi(k)= temp_scarto_m_bi(k);
                    matrix_t_bi(d,j)=temp_matrix_t_bi(d,j);
                    matrix_m_bi(d,j)=temp_matrix_m_bi(d,j);
                    Profit_scarto_bi = scarto_t_bi .* scarto_m_bi;
                   
                end
                
            end
            
        end
    end
end


matrix_t_bi;
matrix_m_bi;
Profit_bi = matrix_t_bi.*matrix_m_bi


%% GRASP

