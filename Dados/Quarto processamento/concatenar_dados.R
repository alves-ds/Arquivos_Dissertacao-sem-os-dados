# Carregar pacotes
library(statsr)
library(dplyr)
library(ggplot2)
library(readxl)
library(lubridate)
library(tidyr)
library(writexl)


# Vamos carregar os dados do IPAQ e do FLEEM que foram processados nas etapas anteriores
dados_ipaq <- read_excel("D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Primeiro processamento/IPAQ/dados_semanas.xlsx")

dados_fleem <- read_excel("D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Terceiro Processamento/FLEEM/resultado_af_processado.xlsx")


# Vamos também carregar os dados com o screening dos participantes, para termos as variáveis que permitam caracterizá-los
dados_caracterizacao <- read_excel("D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Sem nenhum processamento/IPAQ/Respostas extraidas do google forms/Screening (respostas)_modificado.xlsx")


# Vamos remover os dados de autoeficácia
dados_caracterizacao <- select(dados_caracterizacao, -c(Nome, 9:14))


# Agora vamos concatenar os bancos de dados, se baseando no ID dos sujeitos. 
dados_concatenados <- dados_fleem %>%
  left_join(dados_ipaq, by = ('ID')) 


dados_concatenados <- dados_concatenados %>%
  left_join(dados_caracterizacao, by = ('ID'))



# Agora vamos salvar o banco de dados, para podermos primeiro modificar o nome das colunas dos dados do IPAQ para indicar cada uma das semanas, e posteriormente prosseguir com a análise dos dados
write_xlsx(dados_concatenados, "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Quarto processamento/dados_concatenados.xlsx")
