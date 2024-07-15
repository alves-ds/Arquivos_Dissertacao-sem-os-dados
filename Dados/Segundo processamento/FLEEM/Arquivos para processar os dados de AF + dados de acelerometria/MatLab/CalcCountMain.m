%
% Este programa foi desenvolvido para calcular o counts.
%
% Colaboradores:
%     Doutorando: William Tsutomu Watanabe
%     Orientador: Prof. Dr. Daniel Gustavo Goroso
%
% É necessário que os seguintes arquivos estejam na mesma pasta:
%     mm2hmsxls.m
%     lim.m
%     ProcessCount.m
%
clear all
close all
clc

%% Definir a hora de dormir e acordar

hdormir = 22; %hora de dormir
hacordar = 6; %hora de acordar

%% Abrir o arquivo index.csv

[FileName,PathName] = uigetfile('index.csv','Selecione o arquivo "index.csv"','index.csv');

if isequal(FileName,0) %arquivo não selecionado
    return
end

if not(strcmp(FileName,'index.csv'))
    errordlg('Apenas o arquivo "index.csv" é aceitável!' ,'Arquivo inválido!');
    return
end

%contagem do tempo
tic

file = csvread(cat(2,PathName,FileName));

%% Carregar idperfil em vetor

idperfil = file(:,1); %Ler a 1ª coluna

%% Varrer todos os arquivos para alocação de memória

MemSize = 0; % Tamanho da memória a ser alocada

% Varrer todas as pastas idperfil
for i=1:length(idperfil)
    
    % Varrer todos os arquivos
    FullPath = strcat(PathName,int2str(idperfil(i)));   
    files = dir(strcat(FullPath,'\*.csv'));
    MemSize = MemSize + length(files);
    
end

% Alocar memória
AF_Data = cell(MemSize,1);

%% Varrer todos os idperfis (pastas)

j=0; % contador de linhas do arquivo

for i=1:length(idperfil)
    
    % Varrer todos os arquivos
    FullPath = strcat(PathName,int2str(idperfil(i)));   
    files = dir(strcat(FullPath,'\*.csv'));
   
    for file = files'
        j=j+1;
        Arquivo = strcat(FullPath,'\',file.name);
                
        [AF] = ProcessCount(Arquivo,idperfil(i),hdormir,hacordar);
        
        AF_Data(j,1) = {AF};
    end
    
end

    %% Escrever arquivo

    %%%%%%%%%%% Atividade Física %%%%%%%%%%%
    
    %escrever arquivo
    AFColumnName = {'IDPerfil;Date;Sleep;Sedentary;Ligth;Moderate;Vigorous;Strong;Total'};
    
    t = cat(1,AFColumnName,AF_Data);
    GE = t';
    FileResult = cat(2,PathName,'Resultado AF.csv');
    fid = fopen(FileResult, 'wt');
    fprintf(fid, '%s\n',GE{:});
    fclose(fid);
    
%% fim da contagem do tempo
s = num2str(toc);

msgbox(cat(2,'Operação Completada em ',s, ' segundos'),'Success');
beep;


