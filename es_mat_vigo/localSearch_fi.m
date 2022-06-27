
function [matrix_t_ls,matrix_m_ls,scarto_t_ls,scarto_m_ls] = localSearch_fi(matrix_t,matrix_m,scarto_t,scarto_m,Profit_scarto,Np,Profit_greedy,T,M,n_scaffali)

matrix_t_ls = matrix_t;
matrix_m_ls = matrix_m;
scarto_t_ls=scarto_t;
scarto_m_ls=scarto_m;
temp_matrix_t_ls = matrix_t_ls;
temp_matrix_m_ls = matrix_m_ls;
temp_scarto_t_ls = scarto_t_ls;
temp_scarto_m_ls = scarto_m_ls;
Profit_scarto_ls=Profit_scarto;



for d = n_scaffali: -1 : 1 %ciclo che scorre le righe della matrice partendo dall'ultima
    for j = 1:Np %ciclo che scorre le colonne della matrice
        for k = 1: length(scarto_t_ls) %ciclo che scorre gli elementi del vettore scarto (elementi fuori dalla soluzione) 

            if ( Profit_greedy(d,j) < Profit_scarto_ls(k)) %condizione che verifica che il profitto fuori dalla soluzione sia migliore di quello in soluzione
          
                temp_matrix_t_ls(d,j) = scarto_t_ls(k); %assegno alla matrice soluzione temporanea dei tempi il tempo k-esimo fuori soluzione
                temp_matrix_m_ls(d,j) = scarto_m_ls(k); %assegno alla matrice soluzione temporanea delle memorie la memoria k-esima fuori soluzione
                temp_scarto_t_ls(k) = matrix_t_ls(d,j); %assegno al vettore temporaneo dello scarto dei tempi l'elemento in soluzione 
                temp_scarto_m_ls(k) = matrix_m_ls(d,j); %assegno al vettore temporaneo dello scarto delle memorie l'elemento in soluzione 

                if (( sum(temp_matrix_t_ls(d,:)) > T ) || (sum(temp_matrix_m_ls(d,:)) > M/n_scaffali)) %condizione che verifica che non vengano superati i valori massimi di memeoria e tempo di ciascun cassetto
                   
                    %se entra qui dentro significa che l'elemento inserito in modo provvisorio ha memoria o tempo troppo grande perciò si ritorna alla soluzione precedente                    
                    temp_scarto_t_ls(k)= scarto_t_ls(k);
                    temp_scarto_m_ls(k)= scarto_m_ls(k);
                    temp_matrix_t_ls(d,j) = matrix_t_ls(d,j);
                    temp_matrix_m_ls(d,j) = matrix_m_ls(d,j);

                else
                    
                    %se entra qui dentro la soluzione temporanea viene inserita all'interno della soluzione finale della local search
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
end

