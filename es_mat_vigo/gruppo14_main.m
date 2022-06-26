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

%riordino vettore time e memory in modo decrescente rispetto al profitto per eseguire il greedy

[matrix_t,matrix_m,Profitto_scaffale,scarto_t,scarto_m] = greedy(time,memory,Np,T,M);

exe_time_greedy=toc %tempo di esecuzione per il greedy

Profitto_totale;
Profitto_scaffale;
scarto_t;
scarto_m;
Profit_scarto = scarto_t .* scarto_m;

matrix_t;
matrix_m;
Profit_greedy= matrix_t.*matrix_m;
Profit_sum_greedy = sum(Profit_greedy,'all')


%% LOCAL SEARCH first improvement

[matrix_t_ls,matrix_m_ls,scarto_t_ls,scarto_m_ls] = localSearch_fi(matrix_t,matrix_m,scarto_t,scarto_m,Profit_scarto,Np,Profit_greedy,T,M);

exe_time_ls = toc %tempo di esecuzione local search

matrix_t;
matrix_m;
matrix_t_ls;
matrix_m_ls;
scarto_t;
scarto_m;
Profit_greedy;
scarto_t_ls;
scarto_m_ls;
Profit_ls = matrix_t_ls.*matrix_m_ls;

 Profit_sum_ls = sum(Profit_ls,'all')
 

%% LOCAL SEARCH best improvement
% scambi = zeros(1,Np); %vettore in cui memorizzo gli indici degli scambi miglioranti
% 
% matrix_t_bi = matrix_t;
% matrix_m_bi = matrix_m;
% scarto_t_bi = scarto_t;
% scarto_m_bi = scarto_m;
% temp_matrix_t_bi = matrix_t_bi;
% temp_matrix_m_bi = matrix_m_bi;
% temp_scarto_t_bi = scarto_t_bi;
% temp_scarto_m_bi = scarto_m_bi;
% Profit_scarto_bi=Profit_scarto;
% miglioramenti = zeros(1,length(scarto_t_bi));
% 
%   for d = 4: -1 : 1 %d-esima riga
%      for j = 1 : Np %j-esima colonna
%         y = 1;
%         for k = 1: length(scarto_t_bi)
%             
%             if ( Profit_greedy(d,j) < Profit_scarto_bi(k))
% 
%                 temp_matrix_t_bi(d,j) = scarto_t_bi(k);
%                 temp_matrix_m_bi(d,j) = scarto_m_bi(k);
%                 temp_scarto_t_bi(k) = matrix_t_bi(d,j);
%                 temp_scarto_m_bi(k) = matrix_m_bi(d,j);
% 
%                 if ( ( sum(temp_matrix_t_bi(d,:)) > T ) || (sum(temp_matrix_m_bi(d,:)) > M/4) )
% 
%                     temp_scarto_t_bi(k)= scarto_t_bi(k);
%                     temp_scarto_m_bi(k)= scarto_m_bi(k);
%                     temp_matrix_t_bi(d,j) = matrix_t_bi(d,j);
%                     temp_matrix_m_bi(d,j) = matrix_m_bi(d,j);
% 
%                 else
% 
%                     miglioramenti(y) = k
%                     temp_scarto_t_bi(k)= scarto_t_bi(k);
%                     temp_scarto_m_bi(k)= scarto_m_bi(k);
%                     temp_matrix_t_bi(d,j) = matrix_t_bi(d,j);
%                     temp_matrix_m_bi(d,j) = matrix_m_bi(d,j);
%                     y = y+1;
%                 end
% 
%             end
% 
%         end
%         
%             best_time = zeros(1,length(scarto_t_bi));
%             best_mem = zeros(1,length(scarto_t_bi));
%         
%         if (miglioramenti ~= zeros(1,length(scarto_t_bi)))
%              
%            for s = 1 : length(miglioramenti)
%                t = miglioramenti(s)
%                best_time = temp_scarto_t_bi(t);
%                best_mem = temp_scarto_m_bi(t);
%            end
%            
%            for i = 1: length(best_time) -1
%                 for h = i+1 : length(best_time)
%                     if(best_time(i)*best_mem(i) <= best_time(h)*best_mem(h))
% 
%                         tmp_t = best_time(i);
%                         tmp_m = best_mem(i);
%                         best_time(i) = best_time(h);
%                         best_mem(i) = best_mem(h);
%                         best_time(h) = tmp_t;
%                         best_mem(h) = tmp_m;
% 
%                     end
%                 end
%            end
%         end
%         best_time
%         best_mem
%         
%          miglioramenti
%          j
%          miglioramenti = zeros(1,length(scarto_t_bi));
%      end
%      
%   end


% matrix_t_bi;
% matrix_m_bi;
% Profit_bi = matrix_t_bi.*matrix_m_bi;



%% GRASP
 %  combinazione di un algoritmo di ricerca locale e di un’euristica randomizzat
 
%STEP 1: euristica randomizzata

[scarto_t_rand, scarto_m_rand, Profit_scarto_rand, matrix_t_rand, matrix_m_rand, Profit_rand] = randHeuristics(time,memory,Np,T,M );

exe_time_rand=toc %tempo di esecuzione euristica randomizzata
Profit_sum_rand = sum(Profit_rand,'all')

%STEP 2: local search

[matrix_t_g,matrix_m_g,Profit_grasp,scarto_t_g,scarto_m_g] = localSearch_grasp(matrix_t_rand,matrix_m_rand,scarto_t_rand,scarto_m_rand,Profit_scarto_rand,Np,Profit_rand,T,M);

exe_time_grasp=toc %tempo esecuzione grasp

matrix_t_rand;
matrix_m_rand;
matrix_t_g;
matrix_m_g;
matrix_t_ls;
matrix_m_ls;
scarto_t;
scarto_m;
scarto_t_g;
scarto_m_g;

Profit_grasp;
Profit_sum_grasp = sum(Profit_grasp,'all');




