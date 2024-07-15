%
% Função Criada por William T. Watanabe em 23/05/2019
%
% Esta função converte um número de minutos (inteiro) para o formato HH:MM
%
% Sintaxe: 
%            x = 567
%            hms = h2hms(x)
%            hms = '09:27'

function [hm] = mm2hms(m)

hora = m/60 - rem((m/60),1); % Retornar a parte inteira da hora
min = m - hora * 60; % Desconta a parte das horas

% ch = char(int2str(hora));
% cm = char(int2str(min));

ch = int2str(hora);
cm = int2str(min);

if(size(ch,2)==1)
    hh = cat(2,'0',ch);
else
    hh = ch;
end

if(size(cm,2)==1)
    mm = cat(2,'0',cm);
else
    mm = cm;
end

hm = cat(2,hh,':',mm);
