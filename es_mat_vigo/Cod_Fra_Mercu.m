clc
clear all

T = 15; %tempo (asse x)
M = 100; %memoria (asse Y)
Np = 22; % numero di processi

time = randi([1 5],1,Np) %vettore dei tempi
memory = randi([1 5],1,Np) %vettore delle memorie
% time= [5,4,5,3,5,3,1,1,2,1,5,5,5,4,2,3,4,1,2,3,4,2]
% memory=[5,5,3,4,2,2,4,3,3,2,5,5,5,4,2,4,3,5,2,3,4,5]
Profitto_totale = 0;
Profit = time.*memory; %profitto dato da tutti i porcessi generati




%% GREEDY

%riordino vettore time e memory in modo decrescente rispetto al profitto
%per eseguire il greedy

[matrix_t,matrix_m,Profitto_scaffale,scarto_t,scarto_m] = greedy(time,memory,Np,T,M );

Profitto_totale;
Profitto_scaffale
scarto_t;
scarto_m;
Profit_scarto = scarto_t .* scarto_m;

matrix_t;
matrix_m;
Profit_greedy= matrix_t.*matrix_m;


%% LOCAL SEARCH first improvement

[matrix_t_ls,matrix_m_ls] = localSearch_fi(matrix_t,matrix_m,scarto_t,scarto_m,Profit_scarto,Np,Profit_greedy,T,M);

matrix_t;
matrix_m;
matrix_t_ls
matrix_m_ls
Profit_greedy;
Profit_ls = matrix_t_ls.*matrix_m_ls


%% LOCAL SEARCH best improvement
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

%  combinazione di un algoritmo di ricerca locale e di un’euristica randomizzata

%risultato euristica randomizzata
[scarto_t_rand, scarto_m_rand, Profit_scarto_rand, matrix_t_rand, matrix_m_rand, Profit_randHeuristics] = randHeuristics(time,memory,Np,T,M )

scarto_t_rand;
scarto_m_rand;
Profit_scarto_rand;
Profit_randHeuristics;



[matrix_t_grasp,matrix_m_grasp,Profit_grasp] = localSearch_grasp(matrix_t_rand,matrix_m_rand,scarto_t_rand,scarto_m_rand,Profit_scarto_rand,Np,Profit_randHeuristics,T,M);
    
matrix_t_grasp;
matrix_m_grasp;
Profit_grasp