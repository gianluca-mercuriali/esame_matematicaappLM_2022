
function [scarto_t_rand, scarto_m_rand, Profit_scarto_rand, matrix_t_rand, matrix_m_rand, Profit_rand] = randHeuristics(time,memory,Np,T,M )

%% EURISTICA RANDOMIZZATA

matrix_t_rand = zeros (4,Np);
 matrix_m_rand = zeros (4,Np);
 soluz_t_rand = zeros(1,Np);
 soluz_m_rand = zeros (1,Np);
 
 temp_t_rand = time;
 temp_m_rand = memory;
 d = 4;
 tx = 0; %sommatoria tempo dello scaffale corrente
 mx = 0; %sommatoria memoria dello scaffale corrente
 k=1;
 x=1;
t = zeros(1, Np); %vettore zeri che conterrà i tempi allocati casualmente dello scaffale corrente
m = zeros (1, Np); % vettore zeri che conterrà le memorie allocate casualmente dello scaffale corrente
 tic
 
%STEP 1: Greedy randomico
for j = 1:4 %ciclo che scorre i 4 scaffali (ho diviso area totale in 4 scaffali)
     
         while  1 %ciclo che mi riempie lo scaffale corrente fino a saturare i tempi

             i = randi(length(temp_t_rand)); %prendo un indice casuale del vettore temporaneo dei tempi
             
             if((tx + temp_t_rand(i) > T) || (mx + temp_m_rand(i) > M/4)) %condizione che controlla che non vengano oltrepassati i limiti di memoria e tempo del cassetto corrente
                break
             else
                tx = tx + temp_t_rand(i); %somma dei tempi che metto nello scaffale corrente
                mx = mx + temp_m_rand(i); %somma delle memorie che metto nello scaffale corrente
                t(k) = temp_t_rand(i); %tempi che metto nello scaffale
                m(k) = temp_m_rand(i); %memorie che metto nello scaffale
                soluz_t_rand(x) = temp_t_rand(i);
                soluz_m_rand(x) = temp_m_rand(i);
                temp_t_rand(i)=[]; %rimuovo il contenuto i-esimo del vettore temporaneo dei tempi
                temp_m_rand(i) =[]; %rimuovo il contenuto i-esimo del vettore temporaneo delle memorie
                k = k + 1;
                x = x + 1;
             end
              
             if (isempty(temp_m_rand) || isempty(temp_t_rand)) %condizione che termina il while se vengono presi tutti gli elementi del vettore tempo (potrebbe non servire nel programma finale)
                break
             end
         end
         
         
         matrix_t_rand(d,:) = t; %costruisco la matrice soluzione dei tempi riempiendola dall'ultima riga
         matrix_m_rand(d,:) = m; %costruisco la matrice soluzione delle memorie riempiendola dall'ultima riga
         Profitto_scaffale = sum(t.*m);
         t = zeros(1, Np);%azzero tutti gli elementi per lo scaffale successivo
         m = zeros(1, Np);%azzero tutti gli elementi per lo scaffale successivo
         k = 1; %resetto il contatore degli indici 
         tx = 0; %azzero la somma dei tempi
         mx = 0; %azzero la somma delle memorie
         d = d-1;
         
         if(isempty(temp_m_rand) || isempty(temp_t_rand)) %potrebbe non servire se uso Np grande
             break
         end
         
end

 
matrix_t_rand;
matrix_m_rand;
scarto_t_rand = temp_t_rand;
scarto_m_rand = temp_m_rand;
Profit_scarto_rand = scarto_t_rand .* scarto_m_rand;
Profit_rand = matrix_t_rand.*matrix_m_rand;



end



