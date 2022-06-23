
function [matrix_t_ls,matrix_m_ls] = localSearch_fi(matrix_t,matrix_m,scarto_t,scarto_m,Profit_scarto,Np,Profit_greedy,T,M)

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

            if ( Profit_greedy(d,j) < Profit_scarto_ls(k))

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

end
