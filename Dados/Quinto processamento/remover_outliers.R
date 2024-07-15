# Carregar os pacotes
library(statsr)
library(dplyr)
library(ggplot2)
library(readxl)
library(lubridate)
library(tidyr)
library(writexl)
library(kableExtra)
library(knitr)


# Vamos carregar o banco de dados para remover os outliers
dados <- read.csv("D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Quinto processamento/banco_dados_reestruturado_identificando_outliers.csv")

# Vamos manter no banco de dados somente aqueles que não são considerados outliers
dados <- dados[dados$Outlier == 0, ]


# Agora vamos salvar esse banco de dados para analisá-lo.
write_xlsx(dados,"D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Quinto processamento/banco_dados_reestruturado_sem_outliers.xlsx")





