# Importar bibliotecas necessárias
import seaborn as sns
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy import stats
import statsmodels.api as sm
from scipy.special import ndtri
import matplotlib.lines as mlines
import matplotlib.transforms as mtransforms
import scipy
from distfit import distfit
import pylab as py
from scipy.stats import gamma
import math


#Importar banco de dados
dados = pd.read_excel('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Modelos mistos/dados_com_residuos.xlsx')

# Vamos remover todos os dados faltantes, para que isso n�o nos atrapalhe a construir os gr�ficos
dados = dados.dropna()


# Agora vamos importar os res�duos e as predi��es feitas pelos modelos

# Caminhada IPAQ
# Modelo com distribui��o linear 
resid_caminhada_linear = list(dados['Residuo_cam_1'].values)
preditos_caminhada_linear = list(dados['Predito_cam_1'].values)

# Modelo com distribui��o gamma
# N�O CONVERGIU


# Atividade f�sica moderada IPAQ

# Modelo com distribui��o linear 
resid_moderada_linear = list(dados['Residuo_mod_1'].values)
preditos_moderada_linear = list(dados['Predito_mod_1'].values)

# Modelo com distribui��o gamma 
# N�O CONVERGIU

  
# Atividade f�sica vigorosa IPAQ

# Modelo com distribui��o linear 
resid_vigorosa_linear = list(dados['Residuo_vig_1'].values)
preditos_vigorosa_linear = list(dados['Predito_vig_1'].values)


# Modelo com distribui��o gamma   
resid_vigorosa_gamma = list(dados['Residuo_vig_2'].values)
preditos_vigorosa_gamma = list(dados['Predito_vig_2'].values)



# Agora, vamos organizar os dados em dataframes

# Caminhada IPAQ
# Modelo com distribui��o linear
caminhada_ipaq_linear_resid = pd.DataFrame(resid_caminhada_linear)
caminhada_ipaq_linear_predito = pd.DataFrame(preditos_caminhada_linear)



# AF moderada
# Modelo com distribui��o linear
moderada_ipaq_linear_resid = pd.DataFrame(resid_moderada_linear)
moderada_ipaq_linear_predito = pd.DataFrame(preditos_moderada_linear)



# AF Vigorosa

# Modelo com distribui��o linear
vigorosa_ipaq_linear_resid = pd.DataFrame(resid_vigorosa_linear)
vigorosa_ipaq_linear_predito = pd.DataFrame(preditos_vigorosa_linear)


# Modelo com distribui��o gamma 
vigorosa_ipaq_gamma_resid = pd.DataFrame(resid_vigorosa_gamma)
vigorosa_ipaq_gamma_predito = pd.DataFrame(preditos_vigorosa_gamma)



# Agora, vamos calcular os percentis observados e te�ricos para construirmos nossos Q-Q plots dos res�duos

# Caminhada IPAQ
# Modelo com distribui��o linear
df_caminhada_linear_resid = caminhada_ipaq_linear_resid.sort_values(by=[0], ascending=True).reset_index()
df_caminhada_linear_resid['count'] = df_caminhada_linear_resid.index + 1
n_rows = df_caminhada_linear_resid.shape[0]
df_caminhada_linear_resid['percentil_area'] = (df_caminhada_linear_resid['count'])/n_rows
df_caminhada_linear_resid['percentil_teorico'] = ndtri(df_caminhada_linear_resid['percentil_area'])
df_caminhada_linear_resid['percentil_atual'] = (df_caminhada_linear_resid[0] - df_caminhada_linear_resid[0].mean())/df_caminhada_linear_resid[0].std(ddof=0)



# AF Moderada
# Modelo com distribui��o linear
df_moderada_linear_resid = moderada_ipaq_linear_resid.sort_values(by=[0], ascending=True).reset_index()
df_moderada_linear_resid['count'] = df_moderada_linear_resid.index + 1
n_rows = df_moderada_linear_resid.shape[0]
df_moderada_linear_resid['percentil_area'] = (df_moderada_linear_resid['count'])/n_rows
df_moderada_linear_resid['percentil_teorico'] = ndtri(df_moderada_linear_resid['percentil_area'])
df_moderada_linear_resid['percentil_atual'] = (df_moderada_linear_resid[0] - df_moderada_linear_resid[0].mean())/df_moderada_linear_resid[0].std(ddof=0)



# AF Vigorosa

# Modelo com distribui��o linear
df_vigorosa_linear_resid = vigorosa_ipaq_linear_resid.sort_values(by=[0], ascending=True).reset_index()
df_vigorosa_linear_resid['count'] = df_vigorosa_linear_resid.index + 1
n_rows = df_vigorosa_linear_resid.shape[0]
df_vigorosa_linear_resid['percentil_area'] = (df_vigorosa_linear_resid['count'])/n_rows
df_vigorosa_linear_resid['percentil_teorico'] = ndtri(df_vigorosa_linear_resid['percentil_area'])
df_vigorosa_linear_resid['percentil_atual'] = (df_vigorosa_linear_resid[0] - df_vigorosa_linear_resid[0].mean())/df_vigorosa_linear_resid[0].std(ddof=0)


# Modelo com distribui��o gamma 
df_vigorosa_gamma_resid = vigorosa_ipaq_gamma_resid.sort_values(by=[0], ascending=True).reset_index()
df_vigorosa_gamma_resid['count'] = df_vigorosa_gamma_resid.index + 1
n_rows = df_vigorosa_gamma_resid.shape[0]
df_vigorosa_gamma_resid['percentil_area'] = (df_vigorosa_linear_resid['count'])/n_rows
df_vigorosa_gamma_resid['percentil_teorico'] = ndtri(df_vigorosa_gamma_resid['percentil_area'])
df_vigorosa_gamma_resid['percentil_atual'] = (df_vigorosa_gamma_resid[0] - df_vigorosa_gamma_resid[0].mean())/df_vigorosa_gamma_resid[0].std(ddof=0)



# Agora vamos construir nossos subplots, contendo Q-Q plots dos res�duos de cada modelo e um scatterplot contendo o predito e o res�duo do modelo, para observar se h� algum vi�s no modelo gerado

# Caminhada IPAQ
fig, (ax1,ax2) = plt.subplots(nrows = 1, ncols = 2, figsize=(6,3), sharey=False)


pp = sm.ProbPlot(df_caminhada_linear_resid.percentil_atual, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax1)
sm.qqline(qq.axes[0], line='45')
ax1.set_ylabel('Quantis observados')
ax1.set_xlabel('Quantis te�ricos (normal)')
ax2.scatter(caminhada_ipaq_linear_predito, caminhada_ipaq_linear_resid, s=3, c='black')
ax2.set_ylabel('Res�duo do modelo')
ax2.set_xlabel('Predito pelo modelo')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/An�lise dos res�duos dos modelos mistos/IPAQ/residuo_modelo_caminhada_ipaq.png', bbox_inches='tight', dpi = 300)
plt.show()



# AF Moderada IPAQ
fig, (ax1,ax2) = plt.subplots(nrows = 1, ncols = 2, figsize=(6,3), sharey=False)


pp = sm.ProbPlot(df_moderada_linear_resid.percentil_atual, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax1)
sm.qqline(qq.axes[0], line='45')
ax1.set_ylabel('Quantis observados')
ax1.set_xlabel('Quantis te�ricos (normal)')
ax2.scatter(moderada_ipaq_linear_predito, moderada_ipaq_linear_resid, s=3, c='black')
ax2.set_ylabel('Res�duo do modelo')
ax2.set_xlabel('Predito pelo modelo')



plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/An�lise dos res�duos dos modelos mistos/IPAQ/residuo_modelo_moderada_ipaq.png', bbox_inches='tight', dpi = 300)
plt.show()


# AF Vigorosa IPAQ
fig, ((ax1,ax2), (ax3,ax4)) = plt.subplots(nrows = 2, ncols = 2, figsize=(8,5), sharey=False)


pp = sm.ProbPlot(df_vigorosa_linear_resid.percentil_atual, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax1)
sm.qqline(qq.axes[0], line='45')
ax1.set_ylabel('Quantis observados')
ax1.set_xlabel('Quantis te�ricos (normal)')
ax2.scatter(vigorosa_ipaq_linear_predito, vigorosa_ipaq_linear_resid, s=3, c='black')
ax2.set_ylabel('Res�duo do modelo')
ax2.set_xlabel('Predito pelo modelo')

pp = sm.ProbPlot(df_vigorosa_gamma_resid.percentil_atual, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax3)
sm.qqline(qq.axes[2], line='45')
ax3.set_ylabel('Quantis observados')
ax3.set_xlabel('Quantis te�ricos (normal)')
ax4.scatter(vigorosa_ipaq_gamma_predito, vigorosa_ipaq_gamma_resid, s=3, c='black')
ax4.set_ylabel('Res�duo do modelo')
ax4.set_xlabel('Predito pelo modelo')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/An�lise dos res�duos dos modelos mistos/IPAQ/residuo_modelo_vigorosa_ipaq.png', bbox_inches='tight', dpi = 300)
plt.show()



##########################################################################################################################################################################################



# Como geramos um banco de dados com os outliers identificados por meio do m�todo de processamento do IPAQ recomendado, faremos a an�lise dos res�duos dos modelos gerados com estes dados tamb�m
dados_sem_outlier1 = pd.read_excel('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Modelos mistos/dados__sem_outliers_com_residuos.xlsx')


# Vamos remover todos os dados faltantes, para que isso n�o nos atrapalhe a construir os gr�ficos
dados_sem_outlier1 = dados_sem_outlier1.dropna()


# Agora vamos importar os res�duos e as predi��es feitas pelos modelos

# Caminhada IPAQ
# Modelo com distribui��o linear 
resid_caminhada_linear = list(dados_sem_outlier1['Residuo_cam__SO_1'].values)
preditos_caminhada_linear = list(dados_sem_outlier1['Predito_cam__SO_1'].values)


# Modelo com distribui��o gamma
# N�O CONVERGIU


# AF Moderada IPAQ
# Modelo com distribui��o linear 
resid_moderada_linear = list(dados_sem_outlier1['Residuo_mod_SO_1'].values)
preditos_moderada_linear = list(dados_sem_outlier1['Predito_mod__SO_1'].values)


# Modelo com distribui��o gamma 
# N�O CONVERGIU

  
# AF Vigorosa IPAQ
# Modelo com distribui��o linear 
resid_vigorosa_linear = list(dados_sem_outlier1['Residuo_vig_SO_1'].values)
preditos_vigorosa_linear = list(dados_sem_outlier1['Predito_vig_SO_1'].values)


# Modelo com distribui��o gamma   
# N�O CONVERGIU



# Agora vamos salvar os dados em dataframes

# Caminhada IPAQ
# Modelo com distribui��o linear
caminhada_ipaq_linear_resid = pd.DataFrame(resid_caminhada_linear)
caminhada_ipaq_linear_predito = pd.DataFrame(preditos_caminhada_linear)



# AF Moderada IPAQ
# Modelo com distribui��o linear
moderada_ipaq_linear_resid = pd.DataFrame(resid_moderada_linear)
moderada_ipaq_linear_predito = pd.DataFrame(preditos_moderada_linear)


  
# AF Vigorosa IPAQ
# Modelo com distribui��o linear
vigorosa_ipaq_linear_resid = pd.DataFrame(resid_vigorosa_linear)
vigorosa_ipaq_linear_predito = pd.DataFrame(preditos_vigorosa_linear)




# Agora, vamos calcular os percentis observados e te�ricos para construirmos nossos Q-Q plots dos res�duos

# Caminhada IPAQ
# Modelo com distribui��o linear
df_caminhada_linear_resid = caminhada_ipaq_linear_resid.sort_values(by=[0], ascending=True).reset_index()
df_caminhada_linear_resid['count'] = df_caminhada_linear_resid.index + 1
n_rows = df_caminhada_linear_resid.shape[0]
df_caminhada_linear_resid['percentil_area'] = (df_caminhada_linear_resid['count'])/n_rows
df_caminhada_linear_resid['percentil_teorico'] = ndtri(df_caminhada_linear_resid['percentil_area'])
df_caminhada_linear_resid['percentil_atual'] = (df_caminhada_linear_resid[0] - df_caminhada_linear_resid[0].mean())/df_caminhada_linear_resid[0].std(ddof=0)



# AF Moderada IPAQ
# Modelo com distribui��o linear
df_moderada_linear_resid = moderada_ipaq_linear_resid.sort_values(by=[0], ascending=True).reset_index()
df_moderada_linear_resid['count'] = df_moderada_linear_resid.index + 1
n_rows = df_moderada_linear_resid.shape[0]
df_moderada_linear_resid['percentil_area'] = (df_moderada_linear_resid['count'])/n_rows
df_moderada_linear_resid['percentil_teorico'] = ndtri(df_moderada_linear_resid['percentil_area'])
df_moderada_linear_resid['percentil_atual'] = (df_moderada_linear_resid[0] - df_moderada_linear_resid[0].mean())/df_moderada_linear_resid[0].std(ddof=0)



# AF Vigorosa IPAQ
# Modelo com distribui��o linear
df_vigorosa_linear_resid = vigorosa_ipaq_linear_resid.sort_values(by=[0], ascending=True).reset_index()
df_vigorosa_linear_resid['count'] = df_vigorosa_linear_resid.index + 1
n_rows = df_vigorosa_linear_resid.shape[0]
df_vigorosa_linear_resid['percentil_area'] = (df_vigorosa_linear_resid['count'])/n_rows
df_vigorosa_linear_resid['percentil_teorico'] = ndtri(df_vigorosa_linear_resid['percentil_area'])
df_vigorosa_linear_resid['percentil_atual'] = (df_vigorosa_linear_resid[0] - df_vigorosa_linear_resid[0].mean())/df_vigorosa_linear_resid[0].std(ddof=0)



# Agora vamos construir nossos subplots, contendo Q-Q plots dos res�duos de cada modelo e um scatterplot contendo o predito e o res�duo do modelo, para observar se h� algum vi�s no modelo gerado

# Caminhada IPAQ
fig, (ax1,ax2) = plt.subplots(nrows = 1, ncols = 2, figsize=(6,3), sharey=False)


pp = sm.ProbPlot(df_caminhada_linear_resid.percentil_atual, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax1)
sm.qqline(qq.axes[0], line='45')
ax1.set_ylabel('Quantis observados')
ax1.set_xlabel('Quantis te�ricos (normal)')
ax2.scatter(caminhada_ipaq_linear_predito, caminhada_ipaq_linear_resid, s=3, c='black')
ax2.set_ylabel('Res�duo do modelo')
ax2.set_xlabel('Predito pelo modelo')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/An�lise dos res�duos dos modelos mistos/IPAQ/Outliers removidos por processamento recomendado IPAQ/residuo_modelo_caminhada_SO_ipaq.png', bbox_inches='tight', dpi = 300)
plt.show()



# AF Moderada IPAQ
fig, (ax1,ax2) = plt.subplots(nrows = 1, ncols = 2, figsize=(6,3), sharey=False)


pp = sm.ProbPlot(df_moderada_linear_resid.percentil_atual, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax1)
sm.qqline(qq.axes[0], line='45')
ax1.set_ylabel('Quantis observados')
ax1.set_xlabel('Quantis te�ricos (normal)')
ax2.scatter(moderada_ipaq_linear_predito, moderada_ipaq_linear_resid, s=3, c='black')
ax2.set_ylabel('Res�duo do modelo')
ax2.set_xlabel('Predito pelo modelo')



plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/An�lise dos res�duos dos modelos mistos/IPAQ/Outliers removidos por processamento recomendado IPAQ/residuo_modelo_moderada_SO_ipaq.png', bbox_inches='tight', dpi = 300)
plt.show()


# AF Vigorosa IPAQ
fig, (ax1,ax2) = plt.subplots(nrows = 1, ncols = 2, figsize=(6,3), sharey=False)


pp = sm.ProbPlot(df_vigorosa_linear_resid.percentil_atual, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax1)
sm.qqline(qq.axes[0], line='45')
ax1.set_ylabel('Quantis observados')
ax1.set_xlabel('Quantis te�ricos (normal)')
ax2.scatter(vigorosa_ipaq_linear_predito, vigorosa_ipaq_linear_resid, s=3, c='black')
ax2.set_ylabel('Res�duo do modelo')
ax2.set_xlabel('Predito pelo modelo')



plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/An�lise dos res�duos dos modelos mistos/IPAQ/Outliers removidos por processamento recomendado IPAQ/residuo_modelo_vigorosa_SO_ipaq.png', bbox_inches='tight', dpi = 300)
plt.show()



##########################################################################################################################################################################################



# Agora, como geramos tamb�m um banco de dados com outliers removidos com base no zscore, devemos avaliar o ajuste dos res�duos destes modelos tamb�m
dados_sem_outlier2 = pd.read_excel('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Modelos mistos/dados__sem_outliers_z_score_com_residuos.xlsx')



# Agora vamos importar os res�duos e as predi��es feitas pelos modelos

# Caminhada IPAQ
# Modelo com distribui��o linear 
resid_caminhada_linear = list(dados_sem_outlier2['Residuo_cam__SO_1'].values)
preditos_caminhada_linear = list(dados_sem_outlier2['Predito_cam__SO_1'].values)

# Modelo com distribui��o gamma
# N�O CONVERGIU


# AF Moderada IPAQ
# Modelo com distribui��o linear 
resid_moderada_linear = list(dados_sem_outlier2['Residuo_mod_SO_1'].values)
preditos_moderada_linear = list(dados_sem_outlier2['Predito_mod__SO_1'].values)


# Modelo com distribui��o gamma 
resid_moderada_gamma = list(dados_sem_outlier2['Residuo_mod_SO_2'].values)
preditos_moderada_gamma = list(dados_sem_outlier2['Predito_mod__SO_2'].values)

  
# AF Vigorosa IPAQ
# Modelo com distribui��o linear 
resid_vigorosa_linear = list(dados_sem_outlier2['Residuo_vig_SO_1'].values)
preditos_vigorosa_linear = list(dados_sem_outlier2['Predito_vig_SO_1'].values)


# Modelo com distribui��o gamma   
# N�O CONVERGIU


# Vamos salvar os dados em dataframes

# Caminhada
# Modelo com distribui��o linear
caminhada_ipaq_linear_resid = pd.DataFrame(resid_caminhada_linear).dropna()
caminhada_ipaq_linear_predito = pd.DataFrame(preditos_caminhada_linear).dropna()



# AF Moderada
# Modelo com distribui��o linear
moderada_ipaq_linear_resid = pd.DataFrame(resid_moderada_linear).dropna()
moderada_ipaq_linear_predito = pd.DataFrame(preditos_moderada_linear).dropna()


# Modelo com distribui��o Gamma
moderada_ipaq_gamma_resid = pd.DataFrame(resid_moderada_gamma).dropna()
moderada_ipaq_gamma_predito = pd.DataFrame(preditos_moderada_gamma).dropna()


  
# AF Vigorosa
# Modelo com distribui��o linear
vigorosa_ipaq_linear_resid = pd.DataFrame(resid_vigorosa_linear).dropna()
vigorosa_ipaq_linear_predito = pd.DataFrame(preditos_vigorosa_linear).dropna()



# Agora, vamos calcular os percentis observados e te�ricos para construirmos nossos Q-Q plots dos res�duos

# Caminhada
# Modelo com distribui��o linear
df_caminhada_linear_resid = caminhada_ipaq_linear_resid.sort_values(by=[0], ascending=True).reset_index()
df_caminhada_linear_resid['count'] = df_caminhada_linear_resid.index + 1
n_rows = df_caminhada_linear_resid.shape[0]
df_caminhada_linear_resid['percentil_area'] = (df_caminhada_linear_resid['count'])/n_rows
df_caminhada_linear_resid['percentil_teorico'] = ndtri(df_caminhada_linear_resid['percentil_area'])
df_caminhada_linear_resid['percentil_atual'] = (df_caminhada_linear_resid[0] - df_caminhada_linear_resid[0].mean())/df_caminhada_linear_resid[0].std(ddof=0)



# AF Moderada
# Modelo com distribui��o linear
df_moderada_linear_resid = moderada_ipaq_linear_resid.sort_values(by=[0], ascending=True).reset_index()
df_moderada_linear_resid['count'] = df_moderada_linear_resid.index + 1
n_rows = df_moderada_linear_resid.shape[0]
df_moderada_linear_resid['percentil_area'] = (df_moderada_linear_resid['count'])/n_rows
df_moderada_linear_resid['percentil_teorico'] = ndtri(df_moderada_linear_resid['percentil_area'])
df_moderada_linear_resid['percentil_atual'] = (df_moderada_linear_resid[0] - df_moderada_linear_resid[0].mean())/df_moderada_linear_resid[0].std(ddof=0)


# Modelo com distribui��o Gamma
df_moderada_gamma_resid = moderada_ipaq_gamma_resid.sort_values(by=[0], ascending=True).reset_index()
df_moderada_gamma_resid['count'] = df_moderada_gamma_resid.index + 1
n_rows = df_moderada_gamma_resid.shape[0]
df_moderada_gamma_resid['percentil_area'] = (df_moderada_gamma_resid['count'])/n_rows
df_moderada_gamma_resid['percentil_teorico'] = ndtri(df_moderada_gamma_resid['percentil_area'])
df_moderada_gamma_resid['percentil_atual'] = (df_moderada_gamma_resid[0] - df_moderada_gamma_resid[0].mean())/df_moderada_gamma_resid[0].std(ddof=0)



# AF Vigorosa
# Modelo com distribui��o linear
df_vigorosa_linear_resid = vigorosa_ipaq_linear_resid.sort_values(by=[0], ascending=True).reset_index()
df_vigorosa_linear_resid['count'] = df_vigorosa_linear_resid.index + 1
n_rows = df_vigorosa_linear_resid.shape[0]
df_vigorosa_linear_resid['percentil_area'] = (df_vigorosa_linear_resid['count'])/n_rows
df_vigorosa_linear_resid['percentil_teorico'] = ndtri(df_vigorosa_linear_resid['percentil_area'])
df_vigorosa_linear_resid['percentil_atual'] = (df_vigorosa_linear_resid[0] - df_vigorosa_linear_resid[0].mean())/df_vigorosa_linear_resid[0].std(ddof=0)



# Agora vamos construir nossos subplots, contendo Q-Q plots dos res�duos de cada modelo e um scatterplot contendo o predito e o res�duo do modelo, para observar se h� algum vi�s no modelo gerado

# Caminhada
fig, (ax1,ax2) = plt.subplots(nrows = 1, ncols = 2, figsize=(6,3), sharey=False)


pp = sm.ProbPlot(df_caminhada_linear_resid.percentil_atual, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax1)
sm.qqline(qq.axes[0], line='45')
ax1.set_ylabel('Quantis observados')
ax1.set_xlabel('Quantis te�ricos (normal)')
ax2.scatter(caminhada_ipaq_linear_predito, caminhada_ipaq_linear_resid, s=3, c='black')
ax2.set_ylabel('Res�duo do modelo')
ax2.set_xlabel('Predito pelo modelo')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/An�lise dos res�duos dos modelos mistos/IPAQ/Outliers removidos z-score/residuo_modelo_caminhada_SO_z_ipaq.png', bbox_inches='tight', dpi = 300)
plt.show()



# AF Moderada
fig, ((ax1,ax2), (ax3, ax4)) = plt.subplots(nrows = 2, ncols = 2, figsize=(8,5), sharey=False)


pp = sm.ProbPlot(df_moderada_linear_resid.percentil_atual, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax1)
sm.qqline(qq.axes[0], line='45')
ax1.set_ylabel('Quantis observados')
ax1.set_xlabel('Quantis te�ricos (normal)')
ax2.scatter(moderada_ipaq_linear_predito, moderada_ipaq_linear_resid, s=3, c='black')
ax2.set_ylabel('Res�duo do modelo')
ax2.set_xlabel('Predito pelo modelo')


pp = sm.ProbPlot(df_moderada_gamma_resid.percentil_atual, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax3)
sm.qqline(qq.axes[2], line='45')
ax3.set_ylabel('Quantis observados')
ax3.set_xlabel('Quantis te�ricos (normal)')
ax4.scatter(moderada_ipaq_gamma_predito, moderada_ipaq_gamma_resid, s=3, c='black')
ax4.set_ylabel('Res�duo do modelo')
ax4.set_xlabel('Predito pelo modelo')


plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/An�lise dos res�duos dos modelos mistos/IPAQ/Outliers removidos z-score/residuo_modelo_moderada_SO_z_ipaq.png', bbox_inches='tight', dpi = 300)
plt.show()


# AF Vigorosa
fig, (ax1,ax2) = plt.subplots(nrows = 1, ncols = 2, figsize=(6,3), sharey=False)


pp = sm.ProbPlot(df_vigorosa_linear_resid.percentil_atual, dist=scipy.stats.distributions.norm, fit=True)
qq = pp.qqplot(marker='.', markerfacecolor='k', markeredgecolor='k', markersize=3, ax=ax1)
sm.qqline(qq.axes[0], line='45')
ax1.set_ylabel('Quantis observados')
ax1.set_xlabel('Quantis te�ricos (normal)')
ax2.scatter(vigorosa_ipaq_linear_predito, vigorosa_ipaq_linear_resid, s=3, c='black')
ax2.set_ylabel('Res�duo do modelo')
ax2.set_xlabel('Predito pelo modelo')



plt.rcParams['axes.labelsize']=12
plt.rcParams['axes.titlesize']=12


plt.tight_layout()
plt.savefig('D:/Projeto_mestrado/Dissertacao/MastersDissertation/An�lise dos res�duos dos modelos mistos/IPAQ/Outliers removidos z-score/residuo_modelo_vigorosa_SO_z_ipaq.png', bbox_inches='tight', dpi = 300)
plt.show()