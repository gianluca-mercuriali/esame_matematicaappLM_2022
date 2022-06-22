clc
clear all

T = 10; %tempo (asse x)
M = 100; %memoria (asse Y)
Np = 14; % numero di processi

% time = randi([1 5],1,Np) %vettore dei tempi
% memory = randi([1 5],1,Np) %vettore delle memorie
time= [5,4,5,3,5,3,1,1,2,1,5,5,5,4]
memory=[5,5,3,4,2,2,4,3,3,2,5,5,5,4]
Profitto_totale = 0;
Profit = time.*memory; %profitto dato da tutti i porcessi generati

tx = 0; %sommatoria tempo dello scaffale corrente
mx = 0; %sommatoria memoria dello scaffale corrente

t = zeros(1, Np); %vettore zeri che conterrà i tempi allocati casualmente dello scaffale corrente
m = zeros (1, Np); % vettore zeri che conterrà le memorie allocate casualmente dello scaffale corrente
matrix_t = zeros (4,Np);
matrix_m = zeros (4,Np);




%% GREEDY

%riordino vettore time e memory in modo decrescente rispetto al profitto
%per eseguire il greedy

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

scarto_t = t_decrescente;
scarto_m = m_decrescente;
temp_t = t_decrescente; %vettore temporaneo dei tempi
temp_m = m_decrescente; %vettore temporaneo delle memorie

r = 1; %indice del vettore scarto
d = 4;
i = 1; % indice che scorre gli elementi del vettore temp_t e temp_m
k=1;
x=1;

t_decrescente
m_decrescente

for j = 1:4 %ciclo che scorre i 4 scaffali (ho diviso area totale in 4 scaffali)
    
    while 1
        if(i > Np) %condizione che fa terminare il while se l'indice che scorre il vettore temp_t è arrivato all'ultimo elemento
            break
        end
        if((tx + temp_t(i) > T) || (mx + temp_m(i) > M/4)) %condizione che controlla che non vengano oltrepassati i limiti di memoria e tempo del cassetto corrente
            %            x = x+1;
            %se entra qui memorizzo il tempo e la memoria corrente nel vettore scarto e il cassetto corrente viene chiuso
            %             scarto_t(r) = temp_t(i) %metto l'elemento nel vettore scarto dei tempi
            %             scarto_m(r) = temp_m(i) %metto l'elemento nel vettore scarto delle memorie
            %             r = r + 1; %incremento l'indice del vettore scarto
            %             i = i + 1; %incremento l'indice che scorre gli elementi del vettore temp_t e temp_m
            break
            
        else
            tx = tx + temp_t(i); %somma dei tempi che metto nello scaffale corrente
            mx = mx + temp_m(i); %somma delle memorie che metto nello scaffale corrente
            t(k) = temp_t(i); %tempi che metto nello scaffale
            m(k) = temp_m(i); %memorie che metto nello scaffale
            scarto_t(x) = []
            scarto_m(x) = []
            
            k = k + 1;
        end
        
        i = i+1; %incremento l'indice che scorre gli elementi del vettore temp_t e temp_m
    end
    
    
    
    matrix_t(d,:) = t; %costruisco la matrice soluzione dei tempi riempiendola dall'ultima riga
    matrix_m(d,:) = m; %costruisco la matrice soluzione delle memorie riempiendola dall'ultima riga
    Profitto_scaffale = sum(t.*m)
    t = zeros(1, Np);%azzero tutti gli elementi per lo scaffale successivo
    m = zeros(1, Np);%azzero tutti gli elementi per lo scaffale successivo
    k = 1; %resetto il contatore degli indici
    tx = 0; %azzero la somma dei tempi
    mx = 0; %azzero la somma delle memorie
    d = d-1;
    x=1;
    
    if(i > Np) %condizione che fa terminare il for se l'indice che scorre il vettore temp_t è arrivato all'ultimo elemento
        break
    end
    
end

Profitto_totale;
scarto_t
scarto_m
Profit_scarto = scarto_t .* scarto_m;

matrix_t
matrix_m
Profit_sol= matrix_t.*matrix_m;

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

                if (( sum(temp_matrix_t_ls(d,:)) > T ) || (sum(temp_matrix_m_ls(d,:)) > M/4))

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
matrix_t;
matrix_m;
matrix_t_ls;
matrix_m_ls;
Profit_sol;
Profit_ls = matrix_t_ls.*matrix_m_ls;

% %% LOCAL SEARCH best improvement
%
%
% matrix_t_bi = matrix_t;
% matrix_m_bi = matrix_m;
% scarto_t_bi=scarto_t;
% scarto_m_bi=scarto_m;
% temp_matrix_t_bi = matrix_t_bi;
% temp_matrix_m_bi = matrix_m_bi;
% temp_scarto_t_bi = scarto_t_bi;
% temp_scarto_m_bi = scarto_m_bi;
% Profit_scarto_bi=Profit_scarto;
%
% for d = 4: -1 : 1 %d-esima riga
%     for j = 1:Np %j-esima colonna
%
%
%         for k = 1: length(scarto_t_bi)
%
%             if ( Profit_sol(d,j) < Profit_scarto_bi(k))
%
%                 temp_matrix_t_bi(d,j) = scarto_t_bi(k);
%                 temp_matrix_m_bi(d,j) = scarto_m_bi(k);
%                 temp_scarto_t_bi(k) = matrix_t_bi(d,j);
%                 temp_scarto_m_bi(k) = matrix_m_bi(d,j);
%
%                 if ( sum(temp_matrix_t_bi(d,:)) > 10 )
%
%                     temp_scarto_t_bi(k)= scarto_t_bi(k);
%                     temp_scarto_m_bi(k)= scarto_m_bi(k);
%                     temp_matrix_t_bi(d,j) = matrix_t_bi(d,j);
%                     temp_matrix_m_bi(d,j) = matrix_m_bi(d,j);
%
%                 else
%
%                     scarto_t_bi(k)= temp_scarto_t_bi(k);
%                     scarto_m_bi(k)= temp_scarto_m_bi(k);
%                     matrix_t_bi(d,j)=temp_matrix_t_bi(d,j);
%                     matrix_m_bi(d,j)=temp_matrix_m_bi(d,j);
%                     Profit_scarto_bi = scarto_t_bi .* scarto_m_bi;
%
%                 end
%
%             end
%
%         end
%     end
% end
%
%
% matrix_t_bi;
% matrix_m_bi;
% Profit_bi = matrix_t_bi.*matrix_m_bi
%
%

%% GRASP


