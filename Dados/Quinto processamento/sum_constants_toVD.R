# Carregar pacotes
library(statsr)
library(dplyr)
library(ggplot2)
library(readxl)
library(lubridate)
library(tidyr)
library(writexl)


# Vamos carregar o banco de dados para somarmos constantes às variáveis
dados_transpostos <- read.csv("D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Quinto processamento/banco_dados_reestruturado.csv")


# Primeiro, vamos verificar se existem valores 0 (zero) no nosso banco de dados
dados_transpostos %>%
  summary()


# A partir disso, vemos que somente a variável "Leve_FLEEM" não possui valores 0. Portanto, somaremos uma constante (10) em todas as demais variáveis.
dados_transpostos$Moderada_FLEEM_10 <- dados_transpostos$Moderada_FLEEM + 10
dados_transpostos$Vigorosa_FLEEM_10 <- dados_transpostos$Vigorosa_FLEEM + 10
dados_transpostos$Caminhada_IPAQ_10 <- dados_transpostos$Caminhada_IPAQ + 10
dados_transpostos$Moderada_IPAQ_10 <- dados_transpostos$Moderada_IPAQ + 10
dados_transpostos$Vigorosa_IPAQ_10 <- dados_transpostos$Vigorosa_IPAQ + 10


# Vamos remover as variáveis antigas para não ficarmos com muitas variáveis no banco de dados que nos confudam
dados_transpostos <- dados_transpostos %>% 
  select(- c(Moderada_FLEEM, Vigorosa_FLEEM, Caminhada_IPAQ, Moderada_IPAQ, Vigorosa_IPAQ))


# Agora vamos verificar se somar a constante resultou no que queríamos: remover os valores 0
dados_transpostos %>%
  summary()


# Agora vamos salvar o nosso banco de dados para usarmos nas análises subsequentes, começando pela análise da distribuição das VDs
write_xlsx(dados_transpostos, "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Quinto processamento/banco_dados_reestruturado.xlsx")
