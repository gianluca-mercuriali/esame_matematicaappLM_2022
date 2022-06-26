function [matrix_t_g,matrix_m_g,Profit_grasp,scarto_t_g,scarto_m_g] = localSearch_grasp(matrix_t_rand,matrix_m_rand,scarto_t_rand,scarto_m_rand,Profit_scarto_rand,Np,Profit_rand,T,M)

matrix_t_g = matrix_t_rand;
matrix_m_g = matrix_m_rand;
scarto_t_g = scarto_t_rand;
scarto_m_g = scarto_m_rand;
temp_matrix_t_g = matrix_t_g;
temp_matrix_m_g = matrix_m_g;
temp_scarto_t_g = scarto_t_g;
temp_scarto_m_g = scarto_m_g;
Profit_scarto_g = Profit_scarto_rand;
Profit_grasp = Profit_rand;
Profit_controllo = Profit_rand;

tic

for t = 1 : 100
    for d = 4: -1 : 1 %ciclo che scorre le righe della matrice partendo dall'ultima
        for j = 1:Np %ciclo che scorre le colonne della matrice
            for k = 1: length(scarto_t_g) %ciclo che scorre gli elementi del vettore scarto (elementi fuori dalla soluzione) 

                if ( Profit_grasp(d,j) < Profit_scarto_g(k)) %condizione che verifica che il profitto fuori dalla soluzione sia migliore di quello in soluzione

                    temp_matrix_t_g(d,j) = scarto_t_g(k); %assegno alla matrice soluzione temporanea dei tempi il tempo k-esimo fuori soluzione
                    temp_matrix_m_g(d,j) = scarto_m_g(k); %assegno alla matrice soluzione temporanea delle memorie la memoria k-esima fuori soluzione
                    temp_scarto_t_g(k) = matrix_t_g(d,j); %assegno al vettore temporaneo dello scarto dei tempi l'elemento in soluzione 
                    temp_scarto_m_g(k) = matrix_m_g(d,j); %assegno al vettore temporaneo dello scarto delle memorie l'elemento in soluzione 

                    if (( sum(temp_matrix_t_g(d,:)) > T ) || (sum(temp_matrix_m_g(d,:)) > M/4)) %condizione che verifica che non vengano superati i valori massimi di memeoria e tempo di ciascun cassetto

                        %se entra qui dentro significa che l'elemento inserito in modo provvisorio ha memoria o tempo troppo grande perciò si ritorna alla soluzione precedente                    
                        temp_scarto_t_g(k)= scarto_t_g(k);
                        temp_scarto_m_g(k)= scarto_m_g(k);
                        temp_matrix_t_g(d,j) = matrix_t_g(d,j);
                        temp_matrix_m_g(d,j) = matrix_m_g(d,j);

                    else

                        %se entra qui dentro la soluzione temporanea viene inserita all'interno della soluzione finale della local search
                        scarto_t_g(k)= temp_scarto_t_g(k);
                        scarto_m_g(k)= temp_scarto_m_g(k);
                        matrix_t_g(d,j)=temp_matrix_t_g(d,j);
                        matrix_m_g(d,j)=temp_matrix_m_g(d,j);
                        Profit_scarto_g = scarto_t_g .* scarto_m_g;
                        Profit_grasp = matrix_t_g.*matrix_m_g;
                        break
                    end

                end

            end
        end
    end
    Profit_grasp = matrix_t_g.*matrix_m_g;
    
    if (Profit_grasp == Profit_controllo)
        break
    else
        Profit_controllo = Profit_grasp;
    end
    
     
end
t
end