%
% Função Criada por William T. Watanabe em 07/08/2019
% Modificada por Douglas Silva Alves em 08/08/2023 para corresponder aos
% pontos de corte propostos por Sasaki et al (2017)
%
% Esta função quantifica os counts em F_lutuação, S_edentário, L_eve,
% M_oderado, V_igoroso e SS_trong.
%


function [f,s,l,m,v,ss] = quant_limiares(count,limiar)

lim = ones(size(count))*limiar;

f = count(count <= lim); % Teste lógico: se verdadeiro f recebe count; 

s = count(and((count > lim),(count <= 199)));

l = count(and((count >= 200),(count <= 2689)));

m = count(and((count >= 2690),(count <= 6166)));

v = count(and((count >= 6167),(count <= 9498)));

ss = count(count >= 9499);