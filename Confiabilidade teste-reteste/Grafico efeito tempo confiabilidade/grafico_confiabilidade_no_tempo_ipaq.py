# Importar bibliotecas necesarias 
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import math
from matplotlib.font_manager import FontProperties

# Este script foi construido para a geracao de um grafico que demonstra o efeito do tempo sobre a confiabilidade das estimativas de AF


# Vamos importar os valores de confiabilidade para os diferentes tempos de monitoramento

########################### Dados para caminhada #########################

# Definindo valores do eixo Y para caminhada 

# Medida unica
ICC_caminhada_2_semanas_mu = 0.53
ICC_caminhada_3_semanas_mu = 0.68
ICC_caminhada_4_semanas_mu = 0.75
ICC_caminhada_5_semanas_mu = 0.72

# Media das medidas
ICC_caminhada_2_semanas_mm = 0.69
ICC_caminhada_3_semanas_mm = 0.86
ICC_caminhada_4_semanas_mm = 0.92
ICC_caminhada_5_semanas_mm = 0.93


# Calculando intervalos de confianca para caminhada

# Medida unica
asymmetric_error_icc_caminhada_2_semanas_mu = [[0.21], [0.15]]
asymmetric_error_icc_caminhada_3_semanas_mu = [[0.12], [0.10]]
asymmetric_error_icc_caminhada_4_semanas_mu = [[0.08], [0.08]]
asymmetric_error_icc_caminhada_5_semanas_mu = [[0.09], [0.08]]


# Media das medidas
asymmetric_error_icc_caminhada_2_semanas_mm = [[0.20], [0.12]]
asymmetric_error_icc_caminhada_3_semanas_mm = [[0.07], [0.05]]
asymmetric_error_icc_caminhada_4_semanas_mm = [[0.03], [0.03]]
asymmetric_error_icc_caminhada_5_semanas_mm = [[0.04], [0.02]]


# Definindo o erro padrao para as estimativas de caminhada
# Medidas unicas
epm_caminhada_2_semanas_mu = 228
epm_caminhada_3_semanas_mu = 197
epm_caminhada_4_semanas_mu = 197
epm_caminhada_5_semanas_mu = 176

epm_caminhada_mu = []


epm_caminhada_mu.append(epm_caminhada_2_semanas_mu)
epm_caminhada_mu.append(epm_caminhada_3_semanas_mu)
epm_caminhada_mu.append(epm_caminhada_4_semanas_mu)
epm_caminhada_mu.append(epm_caminhada_5_semanas_mu)



# Media das medidas
epm_caminhada_2_semanas_mm = 185
epm_caminhada_3_semanas_mm = 130
epm_caminhada_4_semanas_mm = 98
epm_caminhada_5_semanas_mm = 88


epm_caminhada_mm = []


epm_caminhada_mm.append(epm_caminhada_2_semanas_mm)
epm_caminhada_mm.append(epm_caminhada_3_semanas_mm)
epm_caminhada_mm.append(epm_caminhada_4_semanas_mm)
epm_caminhada_mm.append(epm_caminhada_5_semanas_mm)


########################### Dados para a intensidade moderada #########################

#Definindo valores do eixo Y para intensidade moderada

# Medida unica
ICC_moderada_2_semanas_mu = 0.82
ICC_moderada_3_semanas_mu = 0.70
ICC_moderada_4_semanas_mu = 0.67
ICC_moderada_5_semanas_mu = 0.58


# Media das medidas
ICC_moderada_2_semanas_mm = 0.90
ICC_moderada_3_semanas_mm = 0.89
ICC_moderada_4_semanas_mm = 0.89
ICC_moderada_5_semanas_mm = 0.87


#Calculando intervalos de confianca para intensidade moderada

# Medida unica
asymmetric_error_icc_moderada_2_semanas_mu = [[0.10], [0.07]]
asymmetric_error_icc_moderada_3_semanas_mu = [[0.11], [0.09]]
asymmetric_error_icc_moderada_4_semanas_mu = [[0.11], [0.09]]
asymmetric_error_icc_moderada_5_semanas_mu = [[0.11], [0.11]]


# Media das medidas
asymmetric_error_icc_moderada_2_semanas_mm = [[0.06], [0.04]]
asymmetric_error_icc_moderada_3_semanas_mm = [[0.06], [0.04]]
asymmetric_error_icc_moderada_4_semanas_mm = [[0.06], [0.04]]
asymmetric_error_icc_moderada_5_semanas_mm = [[0.06], [0.05]]


# Definindo o erro padrao para as estimativas de af moderada

# Medidas unicas
epm_moderada_2_semanas_mu = 163
epm_moderada_3_semanas_mu = 205
epm_moderada_4_semanas_mu = 170
epm_moderada_5_semanas_mu = 180


epm_moderada_mu = []


epm_moderada_mu.append(epm_moderada_2_semanas_mu)
epm_moderada_mu.append(epm_moderada_3_semanas_mu)
epm_moderada_mu.append(epm_moderada_4_semanas_mu)
epm_moderada_mu.append(epm_moderada_5_semanas_mu)



# Media das medidas
epm_moderada_2_semanas_mm = 122
epm_moderada_3_semanas_mm = 135
epm_moderada_4_semanas_mm = 96
epm_moderada_5_semanas_mm = 90

epm_moderada_mm = []


epm_moderada_mm.append(epm_moderada_2_semanas_mm)
epm_moderada_mm.append(epm_moderada_3_semanas_mm)
epm_moderada_mm.append(epm_moderada_4_semanas_mm)
epm_moderada_mm.append(epm_moderada_5_semanas_mm)


########################### Dados para a intensidade vigorosa #########################
#Definindo valores do eixo Y para intensidade vigorosa

# Medida unica
ICC_vigorosa_2_semanas_mu = 0.76
ICC_vigorosa_3_semanas_mu = 0.70
ICC_vigorosa_4_semanas_mu = 0.71
ICC_vigorosa_5_semanas_mu = 0.73


# Media das medidas
ICC_vigorosa_2_semanas_mm = 0.86
ICC_vigorosa_3_semanas_mm = 0.87
ICC_vigorosa_4_semanas_mm = 0.91
ICC_vigorosa_5_semanas_mm = 0.93


#Calculando intervalos de confianca para intensidade vigorosa

# Medida unica
asymmetric_error_icc_vigorosa_2_semanas_mu = [[0.13], [0.08]]
asymmetric_error_icc_vigorosa_3_semanas_mu = [[0.11], [0.09]]
asymmetric_error_icc_vigorosa_4_semanas_mu = [[0.10], [0.09]]
asymmetric_error_icc_vigorosa_5_semanas_mu = [[0.09], [0.08]]


# Media das medidas
asymmetric_error_icc_vigorosa_2_semanas_mm = [[0.09], [0.06]]
asymmetric_error_icc_vigorosa_3_semanas_mm = [[0.06], [0.05]]
asymmetric_error_icc_vigorosa_4_semanas_mm = [[0.05], [0.03]]
asymmetric_error_icc_vigorosa_5_semanas_mm = [[0.03], [0.02]]

# Definindo o erro padrao para as estimativas de af vigorosa

# Medidas unicas
epm_vigorosa_2_semanas_mu = 72
epm_vigorosa_3_semanas_mu = 89
epm_vigorosa_4_semanas_mu = 88
epm_vigorosa_5_semanas_mu = 84


# Medidas medias
epm_vigorosa_2_semanas_mm = 55
epm_vigorosa_3_semanas_mm = 59
epm_vigorosa_4_semanas_mm = 49
epm_vigorosa_5_semanas_mm = 43



epm_vigorosa_mu = []


epm_vigorosa_mu.append(epm_vigorosa_2_semanas_mu)
epm_vigorosa_mu.append(epm_vigorosa_3_semanas_mu)
epm_vigorosa_mu.append(epm_vigorosa_4_semanas_mu)
epm_vigorosa_mu.append(epm_vigorosa_5_semanas_mu)


epm_vigorosa_mm = []


epm_vigorosa_mm.append(epm_vigorosa_2_semanas_mm)
epm_vigorosa_mm.append(epm_vigorosa_3_semanas_mm)
epm_vigorosa_mm.append(epm_vigorosa_4_semanas_mm)
epm_vigorosa_mm.append(epm_vigorosa_5_semanas_mm)

# Construir subplots com o efeito das medidas sobre as estimativas de confiabilidade

semanas = ['2 Semanas', '3 Semanas', '4 Semanas', '5 Semanas']


#graficos com dados de caminhada
fig, ax = plt.subplots(nrows = 3, ncols = 2, figsize=(9, 10), sharex=True)

# Dados de ICC e intervalo de confianca
# Medida unica
ax[0,0].errorbar(['2 Semanas'], [ICC_caminhada_2_semanas_mu], yerr=asymmetric_error_icc_caminhada_2_semanas_mu, fmt='-o', color = '#228B22')
ax[0,0].errorbar(['3 Semanas'], [ICC_caminhada_3_semanas_mu], yerr=asymmetric_error_icc_caminhada_3_semanas_mu, fmt='-o', color = '#228B22')
ax[0,0].errorbar(['4 Semanas'], [ICC_caminhada_4_semanas_mu], yerr=asymmetric_error_icc_caminhada_4_semanas_mu, fmt='-o', color = '#228B22')
ax[0,0].errorbar(['5 Semanas'], [ICC_caminhada_5_semanas_mu], yerr=asymmetric_error_icc_caminhada_5_semanas_mu, fmt='-o', color = '#228B22')

# Media das medidas
ax[0,0].errorbar(['2 Semanas'], [ICC_caminhada_2_semanas_mm], yerr=asymmetric_error_icc_caminhada_2_semanas_mm, fmt='-o', color = '#228B22', marker='x')
ax[0,0].errorbar(['3 Semanas'], [ICC_caminhada_3_semanas_mm], yerr=asymmetric_error_icc_caminhada_3_semanas_mm, fmt='-o', color = '#228B22', marker='x')
ax[0,0].errorbar(['4 Semanas'], [ICC_caminhada_4_semanas_mm], yerr=asymmetric_error_icc_caminhada_4_semanas_mm, fmt='-o', color = '#228B22', marker='x')
ax[0,0].errorbar(['5 Semanas'], [ICC_caminhada_5_semanas_mm], yerr=asymmetric_error_icc_caminhada_5_semanas_mm, fmt='-o', color = '#228B22', marker='x')


ax[0,0].set_ylabel('Confiabilidade (ICC)')
ax[0,0].set_ylim(0,1)


# Inserir dados com o erro padrao da medida
ax[0,1].plot(semanas, epm_caminhada_mu, color = '#228B22',linestyle='-', marker = 'o', markersize = 4, label = 'Caminhada')
ax[0,1].plot(semanas, epm_caminhada_mm, color = '#228B22',linestyle='dotted', marker = 'x', markersize = 4)
ax[0,1].set_ylabel('Confiabilidade (EPM)')


#graficos com dados de atividade fisica moderada

# Dados de ICC e intervalo de confianca
# Medida unica
ax[1,0].errorbar(['2 Semanas'], [ICC_moderada_2_semanas_mu], yerr=asymmetric_error_icc_moderada_2_semanas_mu, fmt='-o', color = '#FF8C00')
ax[1,0].errorbar(['3 Semanas'], [ICC_moderada_3_semanas_mu], yerr=asymmetric_error_icc_moderada_3_semanas_mu, fmt='-o', color = '#FF8C00')
ax[1,0].errorbar(['4 Semanas'], [ICC_moderada_4_semanas_mu], yerr=asymmetric_error_icc_moderada_4_semanas_mu, fmt='-o', color = '#FF8C00')
ax[1,0].errorbar(['5 Semanas'], [ICC_moderada_5_semanas_mu], yerr=asymmetric_error_icc_moderada_5_semanas_mu, fmt='-o', color = '#FF8C00')

# Media das medidas
ax[1,0].errorbar(['2 Semanas'], [ICC_moderada_2_semanas_mm], yerr=asymmetric_error_icc_moderada_2_semanas_mm, fmt='-o', color = '#FF8C00', marker='x')
ax[1,0].errorbar(['3 Semanas'], [ICC_moderada_3_semanas_mm], yerr=asymmetric_error_icc_moderada_3_semanas_mm, fmt='-o', color = '#FF8C00', marker='x')
ax[1,0].errorbar(['4 Semanas'], [ICC_moderada_4_semanas_mm], yerr=asymmetric_error_icc_moderada_4_semanas_mm, fmt='-o', color = '#FF8C00', marker='x')
ax[1,0].errorbar(['5 Semanas'], [ICC_moderada_5_semanas_mm], yerr=asymmetric_error_icc_moderada_5_semanas_mm, fmt='-o', color = '#FF8C00', marker='x')


ax[1,0].set_ylabel('Confiabilidade (ICC)')
ax[1,0].set_ylim(0,1)

# Inserir dados com o erro padrao da medida
ax[1,1].plot(semanas, epm_moderada_mu, color = '#FF8C00',linestyle='-', marker = 'o', markersize = 4, label = 'Moderada')
ax[1,1].plot(semanas, epm_moderada_mm, color = '#FF8C00',linestyle='dotted', marker = 'x', markersize = 4)
ax[1,1].set_ylabel('Confiabilidade (EPM)')



#graficos com dados de atividade fisica vigorosa

# Dados de ICC e intervalo de confianca

# Medida unica
ax[2,0].errorbar(['2 Semanas'], [ICC_vigorosa_2_semanas_mu], yerr=asymmetric_error_icc_vigorosa_2_semanas_mu, fmt='-o', color = '#FF0000')
ax[2,0].errorbar(['3 Semanas'], [ICC_vigorosa_3_semanas_mu], yerr=asymmetric_error_icc_vigorosa_3_semanas_mu, fmt='-o', color = '#FF0000')
ax[2,0].errorbar(['4 Semanas'], [ICC_vigorosa_4_semanas_mu], yerr=asymmetric_error_icc_vigorosa_4_semanas_mu, fmt='-o', color = '#FF0000')
ax[2,0].errorbar(['5 Semanas'], [ICC_vigorosa_5_semanas_mu], yerr=asymmetric_error_icc_vigorosa_5_semanas_mu, fmt='-o', color = '#FF0000')

# Media das medidas
ax[2,0].errorbar(['2 Semanas'], [ICC_vigorosa_2_semanas_mm], yerr=asymmetric_error_icc_vigorosa_2_semanas_mm, fmt='-o', color = '#FF0000', marker='x')
ax[2,0].errorbar(['3 Semanas'], [ICC_vigorosa_3_semanas_mm], yerr=asymmetric_error_icc_vigorosa_3_semanas_mm, fmt='-o', color = '#FF0000', marker='x')
ax[2,0].errorbar(['4 Semanas'], [ICC_vigorosa_4_semanas_mm], yerr=asymmetric_error_icc_vigorosa_4_semanas_mm, fmt='-o', color = '#FF0000', marker='x')
ax[2,0].errorbar(['5 Semanas'], [ICC_vigorosa_5_semanas_mm], yerr=asymmetric_error_icc_vigorosa_5_semanas_mm, fmt='-o', color = '#FF0000', marker='x')


ax[2,0].set_ylabel('Confiabilidade (ICC)')
ax[2,0].set_ylim(0,1)

# Inserir dados com o erro padrao da medida
ax[2,1].plot(semanas, epm_vigorosa_mu, color = '#FF0000',linestyle='-', marker = 'o', markersize = 4, label = 'Vigorosa')
ax[2,1].plot(semanas, epm_vigorosa_mm, color = '#FF0000',linestyle='dotted', marker = 'x', markersize = 4)
ax[2,1].set_ylabel('Confiabilidade (EPM)')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
fontP = FontProperties()
fontP.set_size('small')
#fig.autofmt_xdate(rotation=45)
fig.legend(loc='lower center', bbox_to_anchor=(0.5, -0.05), fancybox=True, shadow=True, ncol=3)
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Confiabilidade teste-reteste/Grafico efeito tempo confiabilidade/confiabilidade_em_fun_do_tempo_ipaq.png', bbox_inches='tight', dpi = 300)
plt.show()

