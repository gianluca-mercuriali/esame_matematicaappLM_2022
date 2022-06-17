clc
clear all

T=5; %tempo (asse x)
M=3; %memoria ( asse Y)
Np=20; % numero di processi

time=rand(1,Np);
memory=rand(1,Np);

Profit=time.*memory; % boxes areas

% tx=0; %sommatoria 
% temp_t = time; %vettore temporaneo di time
% temp_p = Profit;
% 
% a = zeros(1, Np); %vettore zeri, che conterrà i processi allocati casualmente
% b = zeros (1, Np); % vettore zeri che conterrà il profitto greedy
% k=1;
% 
% 
% % %greedy brutale --> prendiamo elmenti del set dei processi e li mettiamo
% dentro in modo casuale 
% 
% while  1
%         
%     i = randi([1,length(temp_t)],1);
%     
%     if( tx + temp_t(i) > T)
%         break
%     else
%         
%     tx= tx + temp_t(i);
%     a(k) = temp_t(i);
%     b(k) = temp_p(i);
%     
%     temp_t(i)=[];
%     temp_p(i) =[];
%     
%     k=k+1;  
%     end
%     
%     if (length(temp_t)==0) %
%         break
%     end
%     
% end
% 
% Profit;

[a,b,tx] = randGreedy(time,Profit,Np,T);
SumProfit=sum(Profit); %profitto max
Profit_greedy = b;
SumProfitGreedy = sum(Profit_greedy); %sommatoria profitto
tx;  %per stampare tx (ok)
a; %come li mette sulla x %per stampare a(ok)


%% Algoritmo greedy max, che mi cerca le scatole massime e le mette dentro, tenendo fuori quelle più piccole



