clc
clear all

T=5; %tempo (asse x)
M=3; %memoria ( asse Y)
Np=20; % numero di processi

time=rand(1,Np);
memory=rand(1,Np);

Profit=time.*memory; % boxes areas


%% greedy brutale --> prendiamo elmenti del set dei processi e li mettiamo

[a,Profit_greedy,mx] = randGreedy(memory,Profit,Np,T);
SumProfit=sum(Profit); %profitto max
SumProfitGreedy = sum(Profit_greedy); %sommatoria profitto
mx;  %per stampare mx (ok)
a; %come li mette sulla x %per stampare a(ok)


%% Algoritmo greedy max, che mi cerca le scatole massime e le mette dentro, tenendo fuori quelle più piccole


%  [a,b,mx] = MaxGreedy(time,Profit,Np,T )
% 
% mx
% a
% Profit_MaxGreedy = b;
% SumProfitMaxGreedy = sum(Profit_MaxGreedy); %sommatoria profitto

%% local search



