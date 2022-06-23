function [matrix_t_grasp,matrix_m_grasp,Profit_grasp] = localSearch_grasp(matrix_t_rand,matrix_m_rand,scarto_t_rand,scarto_m_rand,Profit_scarto_rand,Np,Profit_randHeuristics,T,M)

temp_Profit_grasp = zeros ( 4,Np);
matrix_t_grasp = matrix_t_rand;
matrix_m_grasp = matrix_m_rand;
scarto_t_grasp=scarto_t_rand;
scarto_m_grasp=scarto_m_rand;
temp_matrix_t_grasp = matrix_t_grasp;
temp_matrix_m_grasp = matrix_m_grasp;
temp_scarto_t_grasp = scarto_t_grasp;
temp_scarto_m_grasp = scarto_m_grasp;
Profit_scarto_grasp=Profit_scarto_rand;

for p = 1: 20
    for d = 4: -1 : 1 %d-esima riga
        for j = 1:Np %j-esima colonna
            
            for k = 1: length(scarto_t_grasp)
                
                if ( Profit_randHeuristics(d,j) < Profit_scarto_grasp(k))
                    
                    temp_matrix_t_grasp(d,j) = scarto_t_grasp(k);
                    temp_matrix_m_grasp(d,j) = scarto_m_grasp(k);
                    temp_scarto_t_grasp(k) = matrix_t_grasp(d,j);
                    temp_scarto_m_grasp(k) = matrix_m_grasp(d,j);
                    
                    if (( sum(temp_matrix_t_grasp(d,:)) > T ) || (sum(temp_matrix_m_grasp(d,:)) > M/4))
                        
                        temp_scarto_t_grasp(k)= scarto_t_grasp(k);
                        temp_scarto_m_grasp(k)= scarto_m_grasp(k);
                        temp_matrix_t_grasp(d,j) = matrix_t_grasp(d,j);
                        temp_matrix_m_grasp(d,j) = matrix_m_grasp(d,j);
                        
                    else
                        
                        scarto_t_grasp(k)= temp_scarto_t_grasp(k);
                        scarto_m_grasp(k)= temp_scarto_m_grasp(k);
                        matrix_t_grasp(d,j)=temp_matrix_t_grasp(d,j);
                        matrix_m_grasp(d,j)=temp_matrix_m_grasp(d,j);
                        Profit_scarto_grasp = scarto_t_grasp .* scarto_m_grasp;
                        break
                    end
                    
                end
                
            end
        end
    end
    
        Profit_grasp = matrix_t_grasp.*matrix_m_grasp;
        
        if ( temp_Profit_grasp == Profit_grasp)
            break
        else
           temp_Profit_grasp=Profit_grasp
           p
        end
        
end

end

