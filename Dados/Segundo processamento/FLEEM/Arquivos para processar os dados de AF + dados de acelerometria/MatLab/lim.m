%
% Fun��o Criada por William T. Watanabe em 06/08/2019
% Modificada por Douglas Silva Alves em 08/08/2023
%
% Esta fun��o calcula automaticamente o limiar de counts (ru�do)
%
% Sintaxe: 
%            c = count[ 1 2 3 4 5]
%            limiar_sleep = limiar(c)
%            limiar_sleep = 12

function [lm] = lim(c)

mincount = min(c); % menor count

if mincount < 200
    count_unicos = unique(c); % Recuperar Counts �nicos
    count_freq = histc(c,count_unicos); % Calcular a Frequ�ncia de count
    max_freq = max(count_freq); % Retornar a maior frequ�ncia
    max_freq_index = find(count_freq == max_freq); % Retornar o �ndice da Freq M�x
    valor_max_freq = count_unicos(max(max_freq_index)); % Retornar o valor da Freq M�x (o maior caso exista 2 ou mais)
    delta_L = valor_max_freq - mincount; % diferen�a entre o menor count e o count de maior freq

    % Retornar o menor valor e somar delta_L
    lm = mincount + 2 * delta_L;
else
    lm = 0;
end