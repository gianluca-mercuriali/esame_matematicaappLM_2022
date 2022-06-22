clc
clear all

T = 10; %tempo (asse x)
M = 100; %memoria (asse Y)
Np=15; % numero di processi

time = randi([1 5],1,Np) %vettore dei tempi
memory = randi([1 5],1,Np) %vettore delle memorie
Profitto_totale = 0;
Profit = time.*memory; %profitto dato da tutti i porcessi generati

tx = 0; %sommatoria tempo dello scaffale corrente
mx = 0; %sommatoria memoria
temp_t = time; %vettore temporaneo dei tempi
temp_m = memory; %vettore temporaneo delle memorie

t = zeros(1, Np); %vettore zeri che conterrà i tempi allocati casualmente dello scaffale corrente
m = zeros (1, Np); % vettore zeri che conterrà le memorie allocate casualmente dello scaffale corrente
matrix_t = zeros (4,Np);
matrix_m = zeros (4,Np);



%% EURISTICA RANDOMIZZATA
k=1;
d=4;

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
    
    
    matrix_t(d,:) = t;
    matrix_m(d,:) = m;
    Profitto_scaffale = sum(t.*m);
    Profitto_totale = Profitto_totale + Profitto_scaffale;
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

Profitto_totale;


scarto_t=temp_t
scarto_m=temp_m
Profit_scarto = scarto_t .* scarto_m
Profit_sol = matrix_t .* matrix_m

matrix_t
matrix_m
