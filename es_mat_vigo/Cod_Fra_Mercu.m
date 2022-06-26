clc
clear all

T = 100; %tempo (asse x)
M = 1000; %memoria (asse Y)
Np = 100; % numero di processi

time = randi([1 20],1,Np); %vettore dei tempi
memory = randi([1 100],1,Np); %vettore delle memorie

Profitto_totale = 0;
Profit = time.*memory; %profitto dato da tutti i porcessi generati




%% GREEDY

%riordino vettore time e memory in modo decrescente rispetto al profitto
%per eseguire il greedy

tic
[matrix_t,matrix_m,Profitto_scaffale,scarto_t,scarto_m] = greedy(time,memory,Np,T,M );

exe_time_greedy=toc %tempo di esecuzione per il greedy


Profitto_totale;
Profitto_scaffale;
scarto_t;
scarto_m;
Profit_scarto = scarto_t .* scarto_m;

matrix_t;
matrix_m;
Profit_greedy= matrix_t.*matrix_m;
profitto_greedy = sum(Profit_greedy,'all')

%% LOCAL SEARCH first improvement

tic
[matrix_t_ls,matrix_m_ls] = localSearch_fi(matrix_t,matrix_m,scarto_t,scarto_m,Profit_scarto,Np,Profit_greedy,T,M);

exe_time_ls=toc %tempo di esecuzione local search
exe_time_gls = exe_time_ls + exe_time_greedy

matrix_t;
matrix_m;
Profit_greedy;

matrix_t_ls;
matrix_m_ls;
Profit_ls = matrix_t_ls.*matrix_m_ls;
profitto_ls = sum(Profit_ls,'all')

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

%  combinazione di un algoritmo di ricerca locale e di un’euristica randomizzat
tic
[scarto_t_rand, scarto_m_rand, Profit_scarto_rand, matrix_t_rand, matrix_m_rand, Profit_rand] = randHeuristics(time,memory,Np,T,M );

exe_time_rand=toc %tempo di esecuzione euristica randomizzata


profitto_rand = sum(Profit_rand,'all')

tic
[matrix_t_g,matrix_m_g,Profit_grasp] = localSearch_grasp(matrix_t_rand,matrix_m_rand,scarto_t_rand,scarto_m_rand,Profit_scarto_rand,Np,Profit_rand,T,M);

exe_time_grasp=toc %tempo esecuzione grasp    
exe_time_graspTot = exe_time_grasp + exe_time_rand


matrix_t_rand
matrix_m_rand
matrix_t_g;
matrix_m_g;
% scarto_t_g
% scarto_m_g

Profit_grasp; 
profitto_grasp = sum(Profit_grasp,'all')