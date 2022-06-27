clc
clear all

T = 100; %tempo (asse x)
M = 1000; %memoria (asse Y)
Np = 100; % numero di processi
n_scaffali = 4;

Result_greedy = zeros(1,10);
Result_time_greedy = zeros(1,10);
Result_ls = zeros(1,10);
Result_time_ls = zeros(1,10);
Result_rand = zeros(1,10);
Result_time_rand = zeros(1,10);
Result_grasp = zeros(1,10);
Result_time_grasp = zeros(1,10);

for h = 1:10 %genero i test 
    time = randi([1 20],1,Np); %vettore dei tempi
    memory = randi([1 100],1,Np); %vettore delle memorie
    Profitto_totale = 0;
    Profit = time.*memory; %profitto dato da tutti i porcessi generati
    
    %% GREEDY
    
    %riordino vettore time e memory in modo decrescente rispetto al profitto per eseguire il greedy
    tic
    [matrix_t,matrix_m,Profitto_scaffale,scarto_t,scarto_m] = greedy(time,memory,Np,T,M,n_scaffali);
    
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
    
    tic
    [matrix_t_ls,matrix_m_ls,scarto_t_ls,scarto_m_ls] = localSearch_fi(matrix_t,matrix_m,scarto_t,scarto_m,Profit_scarto,Np,Profit_greedy,T,M,n_scaffali);
    
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
    
    %% GRASP
    %  combinazione di un algoritmo di ricerca locale e di un’euristica randomizzat
    
    %STEP 1: euristica randomizzata
    
    tic
    [scarto_t_rand, scarto_m_rand, Profit_scarto_rand, matrix_t_rand, matrix_m_rand, Profit_rand] = randHeuristics(time,memory,Np,T,M,n_scaffali );
    
    exe_time_rand=toc %tempo di esecuzione euristica randomizzata
    Profit_sum_rand = sum(Profit_rand,'all')
    
    %STEP 2: local search
    
    tic
    [matrix_t_g,matrix_m_g,Profit_grasp,scarto_t_g,scarto_m_g] = localSearch_grasp(matrix_t_rand,matrix_m_rand,scarto_t_rand,scarto_m_rand,Profit_scarto_rand,Np,Profit_rand,T,M,n_scaffali);
    
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
    
    Profit_grasp
    Profit_sum_grasp = sum(Profit_grasp,'all');
    
    Result_greedy(h) = Profit_sum_greedy;
    Result_time_greedy(h) = exe_time_greedy;
    Result_ls(h) = Profit_sum_ls;
    Result_time_ls(h) = exe_time_ls;
    Result_rand(h) = Profit_sum_rand;
    Result_time_rand(h) = exe_time_rand;
    Result_grasp(h) = Profit_sum_grasp;
    Result_time_grasp(h) = exe_time_grasp;
    
end


Result_greedy
Result_time_greedy
Result_ls
Result_time_ls
Result_rand
Result_time_rand
Result_grasp
Result_time_grasp

Media_greedy = mean(Result_greedy)
Media_time_greedy = mean(Result_time_greedy)
Media_ls = mean(Result_ls)
Media_time_ls = mean(Result_time_ls)
Media_rand = mean(Result_rand)
Media_time_rand = mean(Result_time_rand)
Media_grasp = mean(Result_grasp)
Media_time_grasp = mean(Result_time_grasp)


