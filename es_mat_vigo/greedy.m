
function [matrix_t,matrix_m,Profitto_scaffale,scarto_t,scarto_m] = greedy(time,memory,Np,T,M,n_scaffali)

%% greedy
%prendiamo elementi del set dei processi, li riordiniamo a partire da quello
% che ha profitto maggiore a quello che ha profitto minore e li mettiamo
% dentro i cassetti, se non ci stanno finiscono nello scarto

%riordino vettore time e memory in modo decrescente rispetto al profitto
%per eseguire il greedy

tx = 0; %sommatoria tempo dello scaffale corrente
mx = 0; %sommatoria memoria dello scaffale corrente
t = zeros(1, Np); %vettore zeri che conterrà i tempi allocati casualmente dello scaffale corrente
m = zeros (1, Np); % vettore zeri che conterrà le memorie allocate casualmente dello scaffale corrente
matrix_t = zeros (n_scaffali,Np);
matrix_m = zeros (n_scaffali,Np);

t_decrescente = time;
m_decrescente = memory;


for i = 1: Np-1
    for j = i+1 : Np
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


d = n_scaffali;
i = 1; % indice che scorre gli elementi del vettore temp_t e temp_m
k = 1;
x = 1;

t_decrescente;
m_decrescente;

for j = 1:n_scaffali %ciclo che scorre i n_scaffali scaffali (ho diviso area totale in n_scaffali scaffali)
    
    while 1
        if(i > Np) %condizione che fa terminare il while se l'indice che scorre il vettore temp_t è arrivato all'ultimo elemento
            break
        end
        if((tx + temp_t(i) > T) || (mx + temp_m(i) > M/n_scaffali)) %condizione che controlla che non vengano oltrepassati i limiti di memoria e tempo del cassetto corrente
            break
            
        else
            tx = tx + temp_t(i); %somma dei tempi che metto nello scaffale corrente
            mx = mx + temp_m(i); %somma delle memorie che metto nello scaffale corrente
            t(k) = temp_t(i); %tempi che metto nello scaffale
            m(k) = temp_m(i); %memorie che metto nello scaffale
            scarto_t(x) = []; 
            scarto_m(x) = [];
            
            k = k + 1;
        end
        
        i = i+1; %incremento l'indice che scorre gli elementi del vettore temp_t e temp_m
    end
    
    
    
    matrix_t(d,:) = t; %costruisco la matrice soluzione dei tempi riempiendola dall'ultima riga
    matrix_m(d,:) = m; %costruisco la matrice soluzione delle memorie riempiendola dall'ultima riga
    Profitto_scaffale = sum(t.*m);
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

end
