%
% Este programa foi desenvolvido para calcular o Gasto Energético através
% da contagem de counts.
%
% Colaboradores:
%     Mestranda:  Nicoli Bertti Zanin
%     Doutorando: William Tsutomu Watanabe
%     Orientador: Prof. Dr. Daniel Gustavo Goroso
%
% Modificado por Douglas Silva Alves em 08/08/2023 para corresponder aos
% pontos de corte propostos por Sasaki et al (2011)
%
% É necessário que os seguintes arquivos estejam na mesma pasta:
%     mm2hmsxls.m
%     lim.m
%     quant_limiares.m
%
function [AF_Data] = ProcessCount(Arquivo,idperfil,hdormir,hacordar)

%% Abrir o arquivo csv;

file = csvread(Arquivo);

%% Carregar valores em vetores

count = file(:,1); %Ler a 1ª coluna
ano = file(:,2); %Ler a 2ª coluna
mes = file(:,3); %Ler a 3ª coluna
dia = file(:,4); %Ler a 4ª coluna
hora = file(:,5); %Ler a 5ª coluna
minut = file(:,6); %Ler a 6ª coluna
seg = file(:,7); %Ler a 7ª coluna

%% Definir a variavel datahora

datahora = datetime(ano,mes,dia,hora,minut,seg);

%% Calcular o Limiar

% Separar os counts entre sleep e wake
count_sleep = count(or((hora >= hdormir),(hora < hacordar)));
count_wake = count(and((hora >= hacordar),(hora < hdormir)));

% Calcular os limiares (flutuação)
lim_sleep = lim(count_sleep);
lim_wake = lim(count_wake);

%% Teste de flutuação
if lim_sleep < 30
    lim_sleep = 30;
end

%% Quantificar os níveis de count (Sedentário, Leve, etc.)
[Rest,s1,l1,m1,v1,ss1] = quant_limiares(count_sleep,lim_sleep);
[Work,s2,l2,m2,v2,ss2] = quant_limiares(count_wake,lim_wake);

% baseline 
% sedentary < 200
% Leve   201  a 2689
% Moderado   2690 a 6166
% Vigoroso   6167 a 9498
% Forte      > 9499

%Basal = count(count <= Limiar); % Teste lógico: se verdadeiro Basal recebe count; 

%Rest = count(and((count <= Lsleep),(or((hora >= hdormir),(hora < hacordar)))));

%Work = count(and((count <= Limiar),(and((hora < hdormir),(hora >= hacordar)))));

% Somar Work ao Seden
Seden = cat(1,s1,s2,Work);

Leve = cat(1,l1,l2);

Moderado = cat(1,m1,m2);

Vigoroso = cat(1,v1,v2);

Strong = cat(1,ss1,ss2);

%% Cálculo de Média, Total, Quantidade e Hora

% mBasal = mean(Basal); % Média de Counts
% TBasal = sum(Basal); % Soma de Counts
% qBasal = size(Basal,1); % Quantidade de Counts (1/minuto)
% hBasal = qBasal/60; % Tempo em horas
% hmsBasal = mm2hmsxls(qBasal); % Tempo em HH:MM

mRest = mean(Rest);
TRest = sum(Rest);
qRest = size(Rest,1);
hRest = qRest/60;
hmsRest = mm2hmsxls(qRest);

mSeden = mean(Seden);
TSeden = sum(Seden);
qSeden = size(Seden,1);
hSeden = qSeden/60;
hmsSeden = mm2hmsxls(qSeden);

mLeve = mean(Leve);
TLeve = sum(Leve);
qLeve = size(Leve,1);
hLeve = qLeve/60;
hmsLeve = mm2hmsxls(qLeve);

mModerado = mean(Moderado);
TModerado = sum(Moderado);
qModerado = size(Moderado,1);
hModerado = qModerado/60;
hmsModerado = mm2hmsxls(qModerado);

mVigoroso = mean(Vigoroso);
TVigoroso = sum(Vigoroso);
qVigoroso = size(Vigoroso,1);
hVigoroso = qVigoroso/60;
hmsVigoroso = mm2hmsxls(qVigoroso);

mStrong = mean(Strong);
TStrong = sum(Strong);
qStrong = size(Strong,1);
hStrong = qStrong/60;
hmsStrong = mm2hmsxls(qStrong);

qTotal = qSeden + qRest + qLeve + qModerado + qVigoroso + qStrong;
hmsTotal = mm2hmsxls(qTotal);

%% Converter idperfil para string
id = int2str(idperfil);

%% Gerar arquivo de saída em csv duração de atividade = AF_Data
%xlColumName = ("IDPerfil;Date;Sleep;Sedentary;Ligth;Moderate;Vigorous;Strong;Total");

xlData = datetime(min(datahora));

xlDatastr = datestr(xlData, 'dd-mm-yyyy');

AF_Data = strrep([id ';' xlDatastr ';' hmsRest ';' hmsSeden ';' hmsLeve ';' hmsModerado ';' hmsVigoroso ';' hmsStrong ';' hmsTotal],'.',',');

end