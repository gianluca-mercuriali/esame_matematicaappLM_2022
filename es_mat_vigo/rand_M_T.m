
function [T,M] = rand_M_T(imin,imax)

%% rand_T_M è una funzione che mi genera M e T casuale    
% Original Author: Mercuriali Gianluca mt.1056381
% Date and version 31/03/2022

T = randi(0.1*[imin, imax])
M = randi([imin, imax])

return 

