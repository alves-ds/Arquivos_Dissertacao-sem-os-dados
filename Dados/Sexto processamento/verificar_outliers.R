# Carregar pacotes
library(statsr)
library(dplyr)
library(ggplot2)
library(readxl)
library(lubridate)
library(tidyr)
library(writexl)


# Vamos carregar o banco de dados para verificar possíveis outliers
dados <- read_excel("D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Quinto processamento/banco_dados_reestruturado_sem_outliers.xlsx")


# Vamos verificar se existem valores omissos no banco de dados
sapply(dados, function(x) sum(is.na(x)))


# Vamos remover esses dados omissos para não atrapalhar no computo do z-score
dados <- na.omit(dados)


# Vamos calcular o z-score das variáveis de caminhada e atividade física de intensidade moderada e vigorosa do IPAQ
dados$z_score_caminhada <- (dados$Caminhada_IPAQ_10-mean(dados$Caminhada_IPAQ_10))/sd(dados$Caminhada_IPAQ_10)
dados$z_score_moderada <- (dados$Moderada_IPAQ_10-mean(dados$Moderada_IPAQ_10))/sd(dados$Moderada_IPAQ_10)
dados$z_score_vigorosa <- (dados$Vigorosa_IPAQ_10-mean(dados$Vigorosa_IPAQ_10))/sd(dados$Vigorosa_IPAQ_10)


# Vamos considerar que valores que estão 3 desvios padrão acima ou abaixo da média são outliers, e removê-los.
# Vamos salvar cada coluna do ipaq em uma variável nova
caminhada_sem_outlier <- dados[dados$z_score_caminhada < 3, c(1, 8, 13)]
moderada_sem_outlier <- dados[dados$z_score_moderada < 3, c(1, 8, 14)]
vigorosa_sem_outlier <- dados[dados$z_score_vigorosa < 3, c(1, 8, 15)]


# Vamos agora criar um banco de dados somente com os dados do IPAQ após a remoção dos outliers
dados_sem_outliers <- vigorosa_sem_outlier %>%
  left_join(moderada_sem_outlier, by = c('ID', 'Semana')) 

dados_sem_outliers <- dados_sem_outliers %>%
  left_join(caminhada_sem_outlier, by = c('ID', 'Semana')) 


# Agora vamos salvar esse banco de dados para analisá-lo. 
write_xlsx(dados_sem_outliers, "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Sexto processamento/banco_dados_reestruturado_sem_outliers.xlsx")
