%SISTEMAS DE CONTROLE TESTES
%REMOVER COMENTARIO PARA TESTAR

%GANHOS
K = 1;
Ki= 0;
%Kd = ;

%FUNÇÃO TRANSFERENCIA 
num = [ K (Ki*K+K) (K*Ki) ];
den = [ 1 20 36 (Ki*K+K) (Ki*K+720)];
g = tf(num, den);

% ENTRADA SENOIDAL - ANALISAR ESTABILIDADE
% [u, t] = gensig('sin', 1, 100, 0.01);
%  lsim(g, u, t)

% POLOS E ZEROS
%rlocus(g);

%INFORMAÇÕES COMPORTAMENTO DO SISTEMA 
%stepinfo(g)

%GRÁFICO COMPORTAMENTO DO SISTEMA 
%step(g)
