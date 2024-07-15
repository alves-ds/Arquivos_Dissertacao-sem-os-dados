#Importar bibliotecas necessárias
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import math
from matplotlib.font_manager import FontProperties


# Importar banco de dados
dados = pd.read_csv('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Confiabilidade teste-reteste/Coeficiente de correla��o intraclasse/IPAQ/dados_ipaq_icc_wide.csv')

# Definidir valores do eixo X dos gráficos
semanas = ['Semana 1', 'Semana 2', 'Semana 3', 'Semana 4', 'Semana 5']


#Separando os dados por intensidade (IPAQ)
#Leve
dados_gerais_af_leve_ipaq = pd.DataFrame()
dados_gerais_af_leve_ipaq['Caminhada_IPAQ_10.1'] = pd.DataFrame(dados['Caminhada_IPAQ_10.1'])
dados_gerais_af_leve_ipaq['Caminhada_IPAQ_10.2'] = dados['Caminhada_IPAQ_10.2']
dados_gerais_af_leve_ipaq['Caminhada_IPAQ_10.3'] = dados['Caminhada_IPAQ_10.3']
dados_gerais_af_leve_ipaq['Caminhada_IPAQ_10.4'] = dados['Caminhada_IPAQ_10.4']
dados_gerais_af_leve_ipaq['Caminhada_IPAQ_10.5'] = dados['Caminhada_IPAQ_10.5']

#Moderada
dados_gerais_af_moderada_ipaq = pd.DataFrame()
dados_gerais_af_moderada_ipaq['Moderada_IPAQ_10.1'] = pd.DataFrame(dados['Moderada_IPAQ_10.1'])
dados_gerais_af_moderada_ipaq['Moderada_IPAQ_10.2'] = dados['Moderada_IPAQ_10.2']
dados_gerais_af_moderada_ipaq['Moderada_IPAQ_10.3'] = dados['Moderada_IPAQ_10.3']
dados_gerais_af_moderada_ipaq['Moderada_IPAQ_10.4'] = dados['Moderada_IPAQ_10.4']
dados_gerais_af_moderada_ipaq['Moderada_IPAQ_10.5'] = dados['Moderada_IPAQ_10.5']

#Vigorosa
dados_gerais_af_vigorosa_ipaq = pd.DataFrame()
dados_gerais_af_vigorosa_ipaq['Vigorosa_IPAQ_10.1'] = pd.DataFrame(dados['Vigorosa_IPAQ_10.1'])
dados_gerais_af_vigorosa_ipaq['Vigorosa_IPAQ_10.2'] = dados['Vigorosa_IPAQ_10.2']
dados_gerais_af_vigorosa_ipaq['Vigorosa_IPAQ_10.3'] = dados['Vigorosa_IPAQ_10.3']
dados_gerais_af_vigorosa_ipaq['Vigorosa_IPAQ_10.4'] = dados['Vigorosa_IPAQ_10.4']
dados_gerais_af_vigorosa_ipaq['Vigorosa_IPAQ_10.5'] = dados['Vigorosa_IPAQ_10.5']


#Separando os dados para cada indivíduo para cada intensidade

#Leve
# Inicialize uma lista vazia para armazenar as listas resultantes
listas_resultantes_leve = []

# Itere pelas linhas do DataFrame e crie uma lista para cada linha
for index, row in dados_gerais_af_leve_ipaq.iterrows():
    # Converte a linha para uma lista e a adiciona � lista de resultados
    lista = row.tolist()
    listas_resultantes_leve.append(lista)
    

#Moderada
# Inicialize uma lista vazia para armazenar as listas resultantes
listas_resultantes_moderada = []

# Itere pelas linhas do DataFrame e crie uma lista para cada linha
for index, row in dados_gerais_af_moderada_ipaq.iterrows():
    # Converte a linha para uma lista e a adiciona � lista de resultados
    lista = row.tolist()
    listas_resultantes_moderada.append(lista)

#Vigorosa
# Inicialize uma lista vazia para armazenar as listas resultantes
listas_resultantes_vigorosa = []

# Itere pelas linhas do DataFrame e crie uma lista para cada linha
for index, row in dados_gerais_af_vigorosa_ipaq.iterrows():
    # Converte a linha para uma lista e a adiciona � lista de resultados
    lista = row.tolist()
    listas_resultantes_vigorosa.append(lista)



########################### Dados para a intensidade leve #########################
#Definindo valores do eixo Y para intensidade leve (com base nos outputs das análises)
leve_semana_1 = 433
leve_semana_2 = 361
leve_semana_3 = 346
leve_semana_4 = 353
leve_semana_5 = 272

#Calculando intervalos de confiança para intensidade leve (com base nos outputs das análises)
ic_leve_sem1 = 1.96*47.4
ic_leve_sem2 = 1.96*46.7
ic_leve_sem3 = 1.96*46.6
ic_leve_sem4 = 1.96*46.4
ic_leve_sem5 = 1.96*46.4

#Definindo o intervalo de confiança do gráfico para intensidade leve
yerr1_leve = ic_leve_sem1
yerr2_leve = ic_leve_sem2
yerr3_leve = ic_leve_sem3
yerr4_leve = ic_leve_sem4
yerr5_leve = ic_leve_sem5

########################### Dados para a intensidade moderada #########################
#Definindo valores do eixo Y para intensidade moderada
moderada_semana_1 = 394
moderada_semana_2 = 397
moderada_semana_3 = 391
moderada_semana_4 = 394
moderada_semana_5 = 395

#Calculando intervalos de confiança para intensidade moderada
ic_mod_sem1 = 1.96*27.8
ic_mod_sem2 = 1.96*28.6
ic_mod_sem3 = 1.96*28.0
ic_mod_sem4 = 1.96*28.1
ic_mod_sem5 = 1.96*28.1

#Definindo o intervalo de confiança do gráfico para intensidade moderada
yerr1_mod = ic_mod_sem1
yerr2_mod = ic_mod_sem2
yerr3_mod = ic_mod_sem3
yerr4_mod = ic_mod_sem4
yerr5_mod = ic_mod_sem5

########################### Dados para a intensidade vigorosa #########################
#Definindo valores do eixo Y para intensidade vigorosa
vigorosa_semana_1 = 147
vigorosa_semana_2 = 129
vigorosa_semana_3 = 157
vigorosa_semana_4 = 132
vigorosa_semana_5 = 130

#Calculando intervalos de confiança para intensidade vigorosa
ic_vig_sem1 = 1.96*22.0
ic_vig_sem2 = 1.96*21.5
ic_vig_sem3 = 1.96*21.6
ic_vig_sem4 = 1.96*21.5
ic_vig_sem5 = 1.96*21.6

#Definindo o intervalo de confiança do gráfico para intensidade vigorosa
yerr1_vig = ic_vig_sem1
yerr2_vig = ic_vig_sem2
yerr3_vig = ic_vig_sem3
yerr4_vig = ic_vig_sem4
yerr5_vig = ic_vig_sem5


#Construindo subplots com gráficos de média e IC e dados individuais ao longo das semanas IPAQ

#Gráficos com dados de atividade física leve
fig, ax = plt.subplots(nrows = 3, ncols = 2, figsize=(9,10), sharex=True)

# Construir gráficos com esperança e IC 95% para cada uma das semanas
ax[0,0].errorbar(['Semana 1'], leve_semana_1, yerr=yerr1_leve, fmt='-o', color = '#228B22')
ax[0,0].errorbar(['Semana 2'], leve_semana_2, yerr=yerr2_leve, fmt='-o', color = '#228B22')
ax[0,0].errorbar(['Semana 3'], leve_semana_3, yerr=yerr3_leve, fmt='-o', color = '#228B22')
ax[0,0].errorbar(['Semana 4'], leve_semana_4, yerr=yerr4_leve, fmt='-o', color = '#228B22')
ax[0,0].errorbar(['Semana 5'], leve_semana_5, yerr=yerr5_leve, fmt='-o', color = '#228B22')


ax[0,0].set_ylabel('Tempo (minutos)')
#ax[0,0].set_yticks(range(0, 2000, 200))

# Construir gráficos com o comportamento de cada indivíduo ao longo das semanas
ax[0,1].plot(semanas, listas_resultantes_leve[0], color = '#228B22',linestyle='-', marker = 'o', markersize = 4, label = 'Caminhada')
ax[0,1].plot(semanas, listas_resultantes_leve[1], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[2], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[3], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[4], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[5], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[6], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[7], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[8], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[9], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[10], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[11], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[12], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[13], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[14], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[15], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[16], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[17], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[18], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[19], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[20], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[21], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[22], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[23], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[24], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[25], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[26], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[27], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[28], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[29], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[30], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[31], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[32], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[33], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[34], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[35], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[36], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[37], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[38], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[39], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[40], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[41], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[42], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[43], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[44], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[45], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[46], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[47], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[48], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[49], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[50], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[51], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[52], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[53], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[54], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[55], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[56], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[57], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[58], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[59], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[60], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[61], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)
ax[0,1].plot(semanas, listas_resultantes_leve[62], color = '#228B22', linestyle='-', marker = 'o', markersize = 4)

#ax[0,1].set_yticks(range(0, 2000, 200))

#Gráficos com dados de atividade física moderada
# Construir gráficos com esperança e IC 95% para cada uma das semanas
ax[1,0].errorbar(['Semana 1'], moderada_semana_1, yerr=yerr1_mod, fmt='-o', color = '#FF8C00')
ax[1,0].errorbar(['Semana 2'], moderada_semana_2, yerr=yerr2_mod, fmt='-o', color = '#FF8C00')
ax[1,0].errorbar(['Semana 3'], moderada_semana_3, yerr=yerr3_mod, fmt='-o', color = '#FF8C00')
ax[1,0].errorbar(['Semana 4'], moderada_semana_4, yerr=yerr4_mod, fmt='-o', color = '#FF8C00')
ax[1,0].errorbar(['Semana 5'], moderada_semana_5, yerr=yerr5_mod, fmt='-o', color = '#FF8C00')

ax[1,0].set_ylabel('Tempo (minutos)')
#ax[1,0].set_yticks(range(0, 2000, 200))

# Construir gráficos com o comportamento de cada indivíduo ao longo das semanas
ax[1,1].plot(semanas, listas_resultantes_moderada[0], color = '#FF8C00',linestyle='-', marker = 'o', markersize = 4, label = 'Moderada')
ax[1,1].plot(semanas, listas_resultantes_moderada[1], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[2], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[3], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[4], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[5], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[6], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[7], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[8], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[9], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[10], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[11], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[12], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[13], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[14], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[15], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[16], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[17], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[18], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[19], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[20], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[21], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[22], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[23], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[24], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[25], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[26], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[27], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[28], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[29], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[30], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[31], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[32], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[33], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[34], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[35], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[36], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[37], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[38], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[39], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[40], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[41], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[42], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[43], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[44], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[45], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[46], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[47], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[48], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[49], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[50], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[51], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[52], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[53], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[54], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[55], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[56], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[57], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[58], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[59], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[60], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[61], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)
ax[1,1].plot(semanas, listas_resultantes_moderada[62], color = '#FF8C00', linestyle='-', marker = 'o', markersize = 4)

#ax[1,1].set_yticks(range(0, 2000, 200))

#Gráficos com dados de atividade física vigorosa
# Construir gráficos com esperança e IC 95% para cada uma das semanas
ax[2,0].errorbar(['Semana 1'], vigorosa_semana_1, yerr=yerr1_vig, fmt='-o', color = '#FF0000')
ax[2,0].errorbar(['Semana 2'], vigorosa_semana_2, yerr=yerr2_vig, fmt='-o', color = '#FF0000')
ax[2,0].errorbar(['Semana 3'], vigorosa_semana_3, yerr=yerr3_vig, fmt='-o', color = '#FF0000')
ax[2,0].errorbar(['Semana 4'], vigorosa_semana_4, yerr=yerr4_vig, fmt='-o', color = '#FF0000')
ax[2,0].errorbar(['Semana 5'], vigorosa_semana_5, yerr=yerr5_vig, fmt='-o', color = '#FF0000')

ax[2,0].set_ylabel('Tempo (minutos)')
#ax[2,0].set_yticks(range(0, 1000, 100))

# Construir gráficos com o comportamento de cada indivíduo ao longo das semanas
ax[2,1].plot(semanas, listas_resultantes_vigorosa[0], color = '#FF0000',linestyle='-', marker = 'o', markersize = 4, label = 'Vigorosa')
ax[2,1].plot(semanas, listas_resultantes_vigorosa[1], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[2], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[3], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[4], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[5], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[6], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[7], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[8], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[9], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[10], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[11], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[12], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[13], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[14], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[15], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[16], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[17], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[18], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[19], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[20], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[21], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[22], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[23], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[24], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[25], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[26], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[27], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[28], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[29], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[30], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[31], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[32], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[33], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[34], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[35], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[36], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[37], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[38], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[39], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[40], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[41], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[42], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[43], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[44], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[45], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[46], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[47], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[48], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[49], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[50], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[51], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[52], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[53], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[54], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[55], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[56], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[57], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[58], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[59], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[60], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[61], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)
ax[2,1].plot(semanas, listas_resultantes_vigorosa[62], color = '#FF0000', linestyle='-', marker = 'o', markersize = 4)

#ax[2,1].set_yticks(range(0, 1000, 100))

plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
fontP = FontProperties()
fontP.set_size('small')
fig.legend(loc='lower center', bbox_to_anchor=(0.5, -0.05), fancybox=True, shadow=True, ncol=3)
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Modelos mistos/Gr�ficos/IPAQ/Dados_IPAQ_ao_longo_do_tempo_1.png', bbox_inches='tight', dpi = 300)
#plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Modelos mistos/Gr�ficos/IPAQ/Dados_IPAQ_ao_longo_do_tempo_2.png', bbox_inches='tight', dpi = 300)
plt.show()

