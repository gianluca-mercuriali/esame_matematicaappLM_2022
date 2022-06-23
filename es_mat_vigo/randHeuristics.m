
function [scarto_t_rand, scarto_m_rand, Profit_scarto_rand, matrix_t_rand, matrix_m_rand, Profit_randHeuristics] = randHeuristics(time,memory,Np,T,M )

%% EURISTICA RANDOMIZZATA

% prendo i processi generati in modo randomico e li metto dentro allo scaffale
% quelli che non ci stanno finiscono nello scarto 

k=1;
d=4;

t = zeros(1, Np); %vettore zeri che conterrà i tempi allocati casualmente dello scaffale corrente
m = zeros (1, Np); % vettore zeri che conterrà le memorie allocate casualmente dello scaffale corrente
matrix_t_rand = zeros (4,Np);
matrix_m_rand = zeros (4,Np);
Profitto_totale_rand = 0;
tx = 0; %sommatoria tempo dello scaffale corrente
mx = 0; %sommatoria memoria
temp_t = time; %vettore temporaneo dei tempi
temp_m = memory; %vettore temporaneo delle memorie


for j = 1:4 %ciclo che scorre i 4 scaffali (ho diviso area totale in 4 scaffali)
    
    %indice delle righe
    while  1 %ciclo che mi riempie lo scaffale corrente fino a saturare i tempi
        
        i = randi(length(temp_t)); %prendo un indice casuale del vettore temporaneo dei tempi
        
        if(temp_m(i) <= M/4) %controllo che verifica che la memoria dell'i-esimo elemento sia inferiore a quella massima contenibile nello scaffale (potrebbe non servire se generiamo memorie dei processi che non superino mai questo limite)
            
            if(( tx + temp_t(i) > T ) || ( mx+temp_m(i) > M/4 )) %condizione che controlla che non si oltrepassi il limite massimo dei tempi
                break
            else
                tx = tx + temp_t(i); %somma dei tempi che metto nello scaffale corrente
                t(k) = temp_t(i); %tempi che metto nello scaffale
                m(k) = temp_m(i); %memorie che metto nello scaffale
                temp_t(i)=[]; %rimuovo il contenuto i-esimo del vettore temporaneo dei tempi
                temp_m(i) =[]; %rimuovo il contenuto i-esimo del vettore temporaneo delle memorie
                
                k=k+1;
                
            end
            
        else %se entra qui significa che l'i-esima memoria è maggiore di quella massima contenibile nello scaffale
            temp_t(i)=[]; %rimuovo il contenuto i-esimo del vettore temporaneo dei tempi
            temp_m(i) =[]; %rimuovo il contenuto i-esimo del vettore temporaneo delle memorie
        end
        if (isempty(temp_t)) %condizione che termina il while se vengono presi tutti gli elementi del vettore tempo (potrebbe non servire nel programma finale)
            break
        end
    end
    
    
    matrix_t_rand(d,:) = t;
    matrix_m_rand(d,:) = m;
    Profitto_scaffale_rand = sum(t.*m);
    Profitto_totale_rand = Profitto_totale_rand + Profitto_scaffale_rand;
    t = zeros(1, Np);%azzero tutti gli elementi per lo scaffale successivo
    m = zeros(1, Np);%azzero tutti gli elementi per lo scaffale successivo
    k=1; %resetto il contatore degli indici
    tx=0; %azzero la somma dei tempi
    mx=0; %azzero la somma delle memorie
    d=d-1; %aggiorno indice che mi fa cambiare scaffale
    
    if(isempty(temp_m) || isempty(temp_t)) %potrebbe non servire se uso Np grande
        break
    end
end

scarto_t_rand=temp_t;
scarto_m_rand=temp_m;
Profit_scarto_rand = scarto_t_rand .* scarto_m_rand;
Profit_randHeuristics = matrix_t_rand .* matrix_m_rand;

end



