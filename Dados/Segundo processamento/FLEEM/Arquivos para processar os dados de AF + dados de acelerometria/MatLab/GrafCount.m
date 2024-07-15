%
% Este programa foi desenvolvido para calcular o Gasto Energético através
% da contagem de counts.
%
% Colaboradores:
%     Mestranda:  Nicoli Bertti Zanin
%     Doutorando: William Tsutomu Watanabe
%     Orientador: Prof. Dr. Daniel Gustavo Goroso
%
% Este programa utiliza as seguintes funções:
%
% mm2hms.m
% lim.m
% quant_limiares.m
%
clear all
close all
clc
%% Definir a hora de dormir e acordar

hdormir = 22; %hora de dormir
hacordar = 6; %hora de acordar

%% Abrir o arquivo do Excel;

[FileName,PathName] = uigetfile('*.xlsx','Select the WORKSHEET file');

if isequal(FileName,0) %arquivo não selecionado
    return
end

file = xlsread(cat(2,PathName,FileName));

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
% sedentary < 759
% Leve   760  a 1952
% Moderado   1953 a 5724
% Vigoroso   5725 a 9498
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


%% Limiares (Gráfico)
Lsleep = zeros(size(count)) + lim_sleep;
Lwake = zeros(size(count)) + lim_wake;
Limiar = Lwake;
Lleve = ones(size(count)) * 760;
Lmoderado = ones(size(count)) * 1953;
Lvigoroso = ones(size(count)) * 5725;
Lforte = ones(size(count)) * 9499;

%% g = número do gráfico
g = 0;

%% Plotar o gráfico de Count X Datahora
g = g+1;

figure(g)
plot(datahora,count,'.',datahora,count,'r',datahora,Lsleep,'c-.',datahora,Lwake,'g-.',datahora,Lleve,'k--',datahora,Lmoderado,'g--',datahora,Lvigoroso,'b--',datahora,Lforte,'m--')
grid
title('Physical Activity')
xlabel('Time [hh:mm]')
ylabel('Count')
legend('Count','Count',cat(2,'LimSleep - ',int2str(lim_sleep)),cat(2,'LimWake - ',int2str(lim_wake)),'Light - 760','Moderate - 1953','Vigorous - 5725','Strong - 9499')

%% Plotar o Total de Count

%  figure(2)
%  stem(count)
%  grid
% title('Physical Activity')
%  xlabel('Hours')
% ylabel('Count')
% legend('Count','Count','Threshold','Light','Moderate','Vigorous','Strong')

%% Quantificação dos limiares
% baseline 
% sedentary < 759
% Leve   760  a 1952
% Moderado   1953 a 5724
% Vigoroso   5725 a 9498
% Forte      > 9499

% Basal = count(count <= Limiar); % Teste lógico: se verdadeiro Basal recebe count; 
% 
% Rest = count(and((count <= Lsleep),(or((hora >= hdormir),(hora < hacordar)))));
% 
% Work = count(and((count <= Limiar),(and((hora < hdormir),(hora >= hacordar)))));
% 
% Seden = count(and((count > Limiar),(count <= 759)));
% 
% Leve = count(and((count >= 760),(count <= 1952)));
% 
% Moderado = count(and((count >= 1953),(count <= 5724)));
% 
% Vigoroso = count(and((count >= 5725),(count <= 9498)));
% 
% Strong = count(count >= 9499);

%% Cálculo de Média, Total, Quantidade e Hora

% mBasal = mean(Basal); % Média de Counts
% TBasal = sum(Basal); % Soma de Counts
% qBasal = size(Basal,1); % Quantidade de Counts (1/minuto)
% hBasal = qBasal/60; % Tempo em horas
% hmsBasal = mm2hms(qBasal); % Tempo em HH:MM

mRest = mean(Rest);
TRest = sum(Rest);
qRest = size(Rest,1);
hRest = qRest/60;
hmsRest = mm2hms(qRest);

mSeden = mean(Seden);
TSeden = sum(Seden);
qSeden = size(Seden,1);
hSeden = qSeden/60;
hmsSeden = mm2hms(qSeden);
hmsSeden1 = mm2hms(qSeden);

mLeve = mean(Leve);
TLeve = sum(Leve);
qLeve = size(Leve,1);
hLeve = qLeve/60;
hmsLeve = mm2hms(qLeve);

mModerado = mean(Moderado);
TModerado = sum(Moderado);
qModerado = size(Moderado,1);
hModerado = qModerado/60;
hmsModerado = mm2hms(qModerado);

mVigoroso = mean(Vigoroso);
TVigoroso = sum(Vigoroso);
qVigoroso = size(Vigoroso,1);
hVigoroso = qVigoroso/60;
hmsVigoroso = mm2hms(qVigoroso);

mStrong = mean(Strong);
TStrong = sum(Strong);
qStrong = size(Strong,1);
hStrong = qStrong/60;
hmsStrong = mm2hms(qStrong);

%% Plot Tcount = Total de Counts

Tcount = TSeden + TLeve + TModerado + TVigoroso + TStrong;
Tcountbar = [TRest TSeden TLeve TModerado TVigoroso TStrong Tcount];
width = 0.3;

g = g+1;
figure(g)

hold on
for i = 1:length(Tcountbar)
    bcount = bar(i,Tcountbar(i));
    
    if i == 7
        set(bcount,'FaceColor','m');
    end
    
    set(bcount,'BarWidth',width);
    
end
hold off

title('Total of Count');
xticks([1 2 3 4 5 6 7 8 9]);
xticklabels({'Sleep','Sedentary','Light','Moderate','Vigour','Strong','Total'});
ylabel('Counts');
legend(cat(2,'Rest: ',char(int2str(TRest))),cat(2,'Sedentary: ',char(int2str(TSeden))),cat(2,'Light: ',char(int2str(TLeve))),cat(2,'Moderate: ',char(int2str(TModerado))),cat(2,'Vigour: ',char(int2str(TVigoroso))),cat(2,'Strong: ',char(int2str(TStrong))),cat(2,'Total: ',char(int2str(Tcount))),'location','northwest');

% xtc = [1 2 3 4 5 6 7 8 9];
% ytc = [-10 TRest+0.3 TWork+0.3 TSeden+0.3 TLeve+0.3 TModerado+0.3 TVigoroso+0.3 TStrong+0.3 Tcount+0.3];
% strc = {char(int2str(TBasal)),char(int2str(TRest)),char(int2str(TWork)),char(int2str(TSeden)),char(int2str(TLeve)),char(int2str(TModerado)),char(int2str(TVigoroso)),char(int2str(TStrong)),char(int2str(Tcount))};
% text(xtc,ytc,strc);

%% Plot mAF = Média de Atividade Física

% mAF = [mBasal mSeden mLeve mModerado mVigoroso mStrong];
% width=0.3;
% 
% figure(3)
% bar(mAF,width)
% title('Mean of Physical Activity');
% xticks([1 2 3 4 5]);
% xticklabels({'Baseline','Sedentary','Ligth','Moderate','Vigorous','Strong'});
% ylabel('Counts');

%% Plot hAF = Horas de Atividade Física
%qTotal = qWork + qSeden + qLeve + qModerado + qVigoroso + qStrong; %!!!!
%qTotal = qBasal + qSeden + qLeve + qModerado + qVigoroso + qStrong;
qTotal = qRest + qSeden + qLeve + qModerado + qVigoroso + qStrong;
hmsTotal = mm2hms(qTotal);
%hTotal = hWork + hSeden + hLeve + hModerado + hVigoroso + hStrong;
%hTotal = hSeden + hLeve + hModerado + hVigoroso + hStrong;
hTotal = qTotal/60;
hAF = [hRest hSeden hLeve hModerado hVigoroso hStrong hTotal];
width=0.3;

g = g+1;
figure(g)

hold on
for i = 1:length(hAF)
    b2 = bar(i,hAF(i));
    
    if i == 7
        set(b2,'FaceColor','m');
    end
    
    set(b2,'BarWidth',width);
end
hold off

title('Physical Activity Time [HH:MM]');
xticks([1 2 3 4 5 6 7]);
xticklabels({'Sleep','Sedentary','Ligth','Moderate','Vigorous','Strong','Total'});
ylabel('Time [HH:MM]');

xt2 = [0.83 1.83 2.83 3.83 4.83 5.83 6.83];
yt2 = [hRest+0.3 hSeden+0.3 hLeve+0.3 hModerado+0.3 hVigoroso+0.3 hStrong+0.3 hTotal+0.3];
str2 = {hmsRest,hmsSeden,hmsLeve,hmsModerado,hmsVigoroso,hmsStrong,hmsTotal};
text(xt2,yt2,str2);

% %% Plot Baseline
% 
% Baseline=[hRest hWork hBasal];
% 
% g = g+1;
% figure(g)
% 
% hold on
% for i = 1:length(Baseline)
%     b3 = bar(i,Baseline(i));
%     
%     if (i == 1) || (i == 2)
%         set(b3,'FaceColor','c');
%     end
%     
%     if i == 3
%         set(b3,'FaceColor','m');
%     end
%     
%     set(b3,'BarWidth',width);
%     
% end
% hold off
% 
% %bar(Baseline,width)
% title('Baseline Time [HH:MM]');
% xticks([1 2 3]);
% xticklabels({'Rest','Work','Baseline'});
% ylabel('Time [HH:MM]');
% 
% % hmsRest = mm2hms(qRest);
% % hmsWork = mm2hms(qWork);
% 
% xt3 = [0.95 1.95 2.95];
% yt3 = [hRest+0.15 hWork+0.15 hBasal+0.15];
% str3 = {hmsRest,hmsWork,hmsBasal};
% text(xt3,yt3,str3);

