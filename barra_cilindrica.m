% Problema de condução em regime estacionario - barra cilindrica 

k = 100;    %Coeficiente de condução - W/m K
L = 0.5;    %Comprimento da barra - m
dx = 0.1;   %Distancia entre pontos - m
A = 0.003;  %Area - m^2
ts1 = 100;  %Temperatura superficie 1 - ºC
ts2 = 500;  %Temperatura superficie 2 - ºC

for i=1:6
    T(i) = 0;
end
T(1)= ts1;
T(6)= ts2;
T = T';
p = 1e-6;
M = [1,0,0,0,0,0
    1,-2,1,0,0,0
    0,1,-2,1,0,0
    0,0,1,-2,1,0
    0,0,0,1,-2,1
    0,0,0,0,0,1];

%gauss_sid(M,T,p) SOLUCIONAR SISTEMA GAUSS-SEIDEL

[x,k]=gauss_sid(M,T,p);
x
k
