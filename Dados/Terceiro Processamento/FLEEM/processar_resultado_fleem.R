# Carregar pacotes
library(statsr)
library(dplyr)
library(ggplot2)
library(readxl)
library(lubridate)
library(tidyr)
library(writexl)


# Carregar banco de dados, após estes serem processados no Matlab
dados <- read.csv("D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Segundo processamento/FLEEM/Arquivos para processar os dados de AF + dados de acelerometria/Accel/Resultado AF.csv", header = TRUE, sep = ";")


# Lista de valores com os IDs dos indivíduos que completaram as 5 semanas
valores_incluir <- c(684, 685, 686, 687, 688, 689, 690, 691, 692, 693, 695, 696, 697, 699, 700, 702, 703, 705, 706, 707, 708, 709, 710, 711, 712, 713, 714, 715, 716, 719, 720, 723, 725, 726, 727, 728, 729, 730, 733, 734, 737, 738, 740, 741, 743, 744, 745, 747, 748, 749, 750, 751, 752, 753, 754, 755, 756, 757, 758, 759, 760, 761, 762, 763)


# criando banco de dados com os indivíduos incluídos
dados_incluidos <- dados %>% 
  filter(IDPerfil %in% valores_incluir)



# Vamos Criar uma função para converter as horas em minutos
converte_para_minutos <- function(tempo) {
  partes <- strsplit(tempo, ":")[[1]]
  horas <- as.numeric(partes[1])
  minutos <- as.numeric(partes[2])
  segundos <- as.numeric(partes[3])
  
  total_minutos <- horas * 60 + minutos + segundos / 60
  return(total_minutos)
}



# aplicando a função no banco de dados
dados_transformados <- dados_incluidos %>%
  mutate(
    LeveMin = sapply(Ligth, converte_para_minutos),
    ModeradaMin = sapply(Moderate, converte_para_minutos),
    VigorosaMin = sapply(Vigorous, converte_para_minutos),
    StrongMin = sapply(Strong, converte_para_minutos)
    )



# Juntar strong e vigorous em uma só variável chamada 'vigorosa'
dados_transformados <- dados_transformados %>%
  mutate(Vigorosa = VigorosaMin + StrongMin)



# Manter só os valores em minutos no dataframe
dados_analise <- dados_transformados %>%
  select(-Sleep, -Sedentary, -Ligth, -Moderate, -Vigorous, -Strong, -VigorosaMin, -StrongMin)



# Convertendo a coluna de data para o formato de data
dados_analise$Date <- dmy(dados_analise$Date)


# Agrupar e organizar os dados com base no ID nos sujeitos e na data de coleta dos dados
dados_ordenados <- dados_analise %>%
  arrange(IDPerfil, Date)



# Agora precisamos agrupar os indivíduos com base na data com que eles foram monitorados, para podermos indicar a data de início e término do período de monitoramento deles e computarmos as quantidades semanais 


###### Agrupar indivíduos que foram monitorados entre 24/04 e 28/05 (684, 685 e 687) #####################
# Indicar os IDs dos indivíduos monitorados neste período
individuos_24a29 <- c(684, 685, 687)


# Criar um banco de dados somente com estes indivíduos
banco_24a29 <- dados_ordenados %>% filter(IDPerfil %in% individuos_24a29)


# Definindo as datas de início e término do monitoramento (de 24/04 a 28/05)
data_limite_inicial24a29 <- as.Date("2023-04-24")
data_limite_final24a29 <- as.Date("2023-05-28")


# Excluindo linhas com datas fora do intervalo
banco_24a29 <- banco_24a29 %>%
  filter(between(Date, data_limite_inicial24a29, data_limite_final24a29))


# Criando uma variável para indicar cada uma das semanas
min_semana <- min(isoweek(banco_24a29$Date))
banco_24a29 <- banco_24a29 %>%
  mutate(semana = isoweek(Date) - min_semana + 1)


#Calculando a quantidade de minutos de AF em cada intensidade, para cada indivíduo em cada semana
banco_24a29 <- banco_24a29 %>%
  group_by(IDPerfil, semana) %>%
  summarise(
    Leve = sum(LeveMin),
    Moderada = sum(ModeradaMin),
    VigorosaS = sum(Vigorosa)
  ) %>%
  pivot_wider(names_from = semana, values_from = c(Leve, Moderada, VigorosaS))

# Salvar o banco de dados destes sujeitos
write_xlsx(banco_24a29, "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Terceiro Processamento/FLEEM/Dados de períodos diferentes/dados_24a29.xlsx")



######### Agrupar indivíduos que foram monitorados entre 01/05 e 04/06 (693, 694, 689, 692, 697, 691, 701, 702, 686, 699, 703, 705, 706) #####################
individuos_01a04 <- c(693, 694, 689, 692, 697, 691, 701, 702, 686, 699, 703, 704, 705, 706)


banco_01a04 <- dados_ordenados %>% 
  filter(IDPerfil %in% individuos_01a04)


# Definindo as datas de limite (de 01/05 a 04/06)
data_limite_inicial01a04 <- as.Date("2023-05-01")
data_limite_final01a04 <- as.Date("2023-06-04")


# Excluindo linhas com datas fora do intervalo
banco_01a04 <- banco_01a04 %>%
  filter(between(Date, data_limite_inicial01a04, data_limite_final01a04))


# Criando uma variável para indicar cada uma das semanas
min_semana <- min(isoweek(banco_01a04$Date))
banco_01a04 <- banco_01a04 %>%
  mutate(semana = isoweek(Date) - min_semana + 1)


#Calculando a quantidade de minutos de AF em cada intensidade, para cada indivíduo em cada semana
banco_01a04 <- banco_01a04 %>%
  group_by(IDPerfil, semana) %>%
  summarise(
    Leve = sum(LeveMin),
    Moderada = sum(ModeradaMin),
    VigorosaS = sum(Vigorosa)
  ) %>%
  pivot_wider(names_from = semana, values_from = c(Leve, Moderada, VigorosaS))


write_xlsx(banco_01a04, "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Terceiro Processamento/FLEEM/Dados de períodos diferentes/dados_01a04.xlsx")


######### Agrupar indivíduos que foram monitorados entre 08/05 e 11/06 (707, 709, 710, 688, 690, 696, 700, 708, 695, 698, 711, 712) #####################
individuos_08a11 <- c(707, 709, 710, 688, 690, 700, 695, 698, 711, 712)

banco_08a11 <- dados_ordenados %>% 
  filter(IDPerfil %in% individuos_08a11)


# Definindo as datas de limite (de 08/05 a 11/06)
data_limite_inicial08a11 <- as.Date("2023-05-08")
data_limite_final08a11 <- as.Date("2023-06-11")


# Excluindo linhas com datas fora do intervalo
banco_08a11 <- banco_08a11 %>%
  filter(between(Date, data_limite_inicial08a11, data_limite_final08a11))


# Criando uma variável para indicar cada uma das semanas
min_semana <- min(isoweek(banco_08a11$Date))
banco_08a11 <- banco_08a11 %>%
  mutate(semana = isoweek(Date) - min_semana + 1)


#Calculando a quantidade de minutos de AF em cada intensidade, para cada indivíduo em cada semana
banco_08a11 <- banco_08a11 %>%
  group_by(IDPerfil, semana) %>%
  summarise(
    Leve = sum(LeveMin),
    Moderada = sum(ModeradaMin),
    VigorosaS = sum(Vigorosa)
  ) %>%
  pivot_wider(names_from = semana, values_from = c(Leve, Moderada, VigorosaS))


write_xlsx(banco_08a11, "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Terceiro Processamento/FLEEM/Dados de períodos diferentes/dados_08a11.xlsx")


######### Agrupar indivíduos que foram monitorados entre 08/05 e 11/06 e tiveram uma semana a mais de monitoramento (696, 708) #####################
individuos_08a11_extendido <- c(696, 708)

banco_08a11_extendido <- dados_ordenados %>% 
  filter(IDPerfil %in% individuos_08a11_extendido)


# Definindo as datas de limite (de 08/05 a 18/06)
data_limite_inicial08a11_extendido <- as.Date("2023-05-08")
data_limite_final08a11_extendido <- as.Date("2023-06-18")


# Excluindo linhas com datas fora do intervalo
banco_08a11_extendido <- banco_08a11_extendido %>%
  filter(between(Date, data_limite_inicial08a11_extendido, data_limite_final08a11_extendido))


# Criando uma variável para indicar cada uma das semanas
min_semana <- min(isoweek(banco_08a11_extendido$Date))
banco_08a11_extendido <- banco_08a11_extendido %>%
  mutate(semana = isoweek(Date) - min_semana + 1)


#Calculando a quantidade de minutos de AF em cada intensidade, para cada indivíduo em cada semana
banco_08a11_extendido <- banco_08a11_extendido %>%
  group_by(IDPerfil, semana) %>%
  summarise(
    Leve = sum(LeveMin),
    Moderada = sum(ModeradaMin),
    VigorosaS = sum(Vigorosa)
  ) %>%
  pivot_wider(names_from = semana, values_from = c(Leve, Moderada, VigorosaS))


write_xlsx(banco_08a11_extendido, "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Terceiro Processamento/FLEEM/Dados de períodos diferentes/dados_08a11_extendido.xlsx")



######### Agrupar indivíduos que foram monitorados entre 15/05 e 18/06 (713, 714) #####################
individuos_15a18 <- c(713, 714)

banco_15a18 <- dados_ordenados %>% 
  filter(IDPerfil %in% individuos_15a18)


# Definindo as datas de limite (de 15/05 a 18/06)
data_limite_inicial15a18 <- as.Date("2023-05-15")
data_limite_final15a18 <- as.Date("2023-06-18")


# Excluindo linhas com datas fora do intervalo
banco_15a18 <- banco_15a18 %>%
  filter(between(Date, data_limite_inicial15a18, data_limite_final15a18))


# Criando uma variável para indicar cada uma das semanas
min_semana <- min(isoweek(banco_15a18$Date))
banco_15a18 <- banco_15a18 %>%
  mutate(semana = isoweek(Date) - min_semana + 1)


#Calculando a quantidade de minutos de AF em cada intensidade, para cada indivíduo em cada semana
banco_15a18 <- banco_15a18 %>%
  group_by(IDPerfil, semana) %>%
  summarise(
    Leve = sum(LeveMin),
    Moderada = sum(ModeradaMin),
    VigorosaS = sum(Vigorosa)
  ) %>%
  pivot_wider(names_from = semana, values_from = c(Leve, Moderada, VigorosaS))


write_xlsx(banco_15a18, "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Terceiro Processamento/FLEEM/Dados de períodos diferentes/dados_15a18.xlsx")


######### Agrupar indivíduos que foram monitorados entre 24/07 e 27/08 (715, 716, 717, 718) #####################
individuos_24a27 <- c(715, 716, 717, 718)


banco_24a27 <- dados_ordenados %>% 
  filter(IDPerfil %in% individuos_24a27)


# Definindo as datas de limite (de 24/07 a 27/08)
data_limite_inicial24a27 <- as.Date("2023-07-24")
data_limite_final24a27 <- as.Date("2023-08-27")


# Excluindo linhas com datas fora do intervalo
banco_24a27 <- banco_24a27 %>%
  filter(between(Date, data_limite_inicial24a27, data_limite_final24a27))


# Criando uma variável para indicar cada uma das semanas
min_semana <- min(isoweek(banco_24a27$Date))
banco_24a27 <- banco_24a27 %>%
  mutate(semana = isoweek(Date) - min_semana + 1)


#Calculando a quantidade de minutos de AF em cada intensidade, para cada indivíduo em cada semana
banco_24a27 <- banco_24a27 %>%
  group_by(IDPerfil, semana) %>%
  summarise(
    Leve = sum(LeveMin),
    Moderada = sum(ModeradaMin),
    VigorosaS = sum(Vigorosa)
  ) %>%
  pivot_wider(names_from = semana, values_from = c(Leve, Moderada, VigorosaS))


write_xlsx(banco_24a27, "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Terceiro Processamento/FLEEM/Dados de períodos diferentes/dados_24a27.xlsx")


######### Agrupar indivíduos que foram monitorados entre 31/07 e 03/09 (719, 721, 722, 723, 724, 727) #####################
individuos_31a03 <- c(719, 721, 722, 723, 724, 725, 727)

banco_31a03 <- dados_ordenados %>% 
  filter(IDPerfil %in% individuos_31a03)


# Definindo as datas de limite (de 31/07 a 03/09)
data_limite_inicial31a03 <- as.Date("2023-07-31")
data_limite_final31a03 <- as.Date("2023-09-03")


# Excluindo linhas com datas fora do intervalo
banco_31a03 <- banco_31a03 %>%
  filter(between(Date, data_limite_inicial31a03, data_limite_final31a03))


# Criando uma variável para indicar cada uma das semanas
min_semana <- min(isoweek(banco_31a03$Date))
banco_31a03 <- banco_31a03 %>%
  mutate(semana = isoweek(Date) - min_semana + 1)


#Calculando a quantidade de minutos de AF em cada intensidade, para cada indivíduo em cada semana
banco_31a03 <- banco_31a03 %>%
  group_by(IDPerfil, semana) %>%
  summarise(
    Leve = sum(LeveMin),
    Moderada = sum(ModeradaMin),
    VigorosaS = sum(Vigorosa)
  ) %>%
  pivot_wider(names_from = semana, values_from = c(Leve, Moderada, VigorosaS))


write_xlsx(banco_31a03, "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Terceiro Processamento/FLEEM/Dados de períodos diferentes/dados_31a03.xlsx")


######### Agrupar indivíduos que foram monitorados entre 07/08 e 10/09 (720, 728, 729, 730, 731, 732, 733, 734, 735, 736, 738) #####################
individuos_07a10 <- c(720, 728, 729, 730, 731, 732, 733, 734, 735, 736, 738)

banco_07a10 <- dados_ordenados %>% 
  filter(IDPerfil %in% individuos_07a10)


# Definindo as datas de limite (de 07/08 a 10/09)
data_limite_inicial07a10 <- as.Date("2023-08-07")
data_limite_final07a10 <- as.Date("2023-09-10")


# Excluindo linhas com datas fora do intervalo
banco_07a10 <- banco_07a10 %>%
  filter(between(Date, data_limite_inicial07a10, data_limite_final07a10))


# Criando uma variável para indicar cada uma das semanas
min_semana <- min(isoweek(banco_07a10$Date))
banco_07a10 <- banco_07a10 %>%
  mutate(semana = isoweek(Date) - min_semana + 1)


#Calculando a quantidade de minutos de AF em cada intensidade, para cada indivíduo em cada semana
banco_07a10 <- banco_07a10 %>%
  group_by(IDPerfil, semana) %>%
  summarise(
    Leve = sum(LeveMin),
    Moderada = sum(ModeradaMin),
    VigorosaS = sum(Vigorosa)
  ) %>%
  pivot_wider(names_from = semana, values_from = c(Leve, Moderada, VigorosaS))


write_xlsx(banco_07a10, "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Terceiro Processamento/FLEEM/Dados de períodos diferentes/dados_07a10.xlsx")


######### Agrupar indivíduos que foram monitorados entre 14/08 e 17/09 (726, 740, 741, 742, 743) #####################
individuos_14a17 <- c(726, 740, 741, 742, 743)

banco_14a17 <- dados_ordenados %>% 
  filter(IDPerfil %in% individuos_14a17)


# Definindo as datas de limite (de 14/08 a 17/09)
data_limite_inicial14a17 <- as.Date("2023-08-14")
data_limite_final14a17 <- as.Date("2023-09-17")


# Excluindo linhas com datas fora do intervalo
banco_14a17 <- banco_14a17 %>%
  filter(between(Date, data_limite_inicial14a17, data_limite_final14a17))


# Criando uma variável para indicar cada uma das semanas
min_semana <- min(isoweek(banco_14a17$Date))
banco_14a17 <- banco_14a17 %>%
  mutate(semana = isoweek(Date) - min_semana + 1)


#Calculando a quantidade de minutos de AF em cada intensidade, para cada indivíduo em cada semana
banco_14a17 <- banco_14a17 %>%
  group_by(IDPerfil, semana) %>%
  summarise(
    Leve = sum(LeveMin),
    Moderada = sum(ModeradaMin),
    VigorosaS = sum(Vigorosa)
  ) %>%
  pivot_wider(names_from = semana, values_from = c(Leve, Moderada, VigorosaS))


write_xlsx(banco_14a17, "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Terceiro Processamento/FLEEM/Dados de períodos diferentes/dados_14a17.xlsx")


######### Agrupar indivíduos que foram monitorados entre 21/08 e 24/09 (744, 746, 747, 748) #####################
individuos_21a24 <- c(744, 746, 747, 748)

banco_21a24 <- dados_ordenados %>% 
  filter(IDPerfil %in% individuos_21a24)


# Definindo as datas de limite (de 21/08 a 24/09)
data_limite_inicial21a24 <- as.Date("2023-08-21")
data_limite_final21a24 <- as.Date("2023-09-24")


# Excluindo linhas com datas fora do intervalo
banco_21a24 <- banco_21a24 %>%
  filter(between(Date, data_limite_inicial21a24, data_limite_final21a24))


# Criando uma variável para indicar cada uma das semanas
min_semana <- min(isoweek(banco_21a24$Date))
banco_21a24 <- banco_21a24 %>%
  mutate(semana = isoweek(Date) - min_semana + 1)


#Calculando a quantidade de minutos de AF em cada intensidade, para cada indivíduo em cada semana
banco_21a24 <- banco_21a24 %>%
  group_by(IDPerfil, semana) %>%
  summarise(
    Leve = sum(LeveMin),
    Moderada = sum(ModeradaMin),
    VigorosaS = sum(Vigorosa)
  ) %>%
  pivot_wider(names_from = semana, values_from = c(Leve, Moderada, VigorosaS))


write_xlsx(banco_21a24, "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Terceiro Processamento/FLEEM/Dados de períodos diferentes/dados_21a24.xlsx")


######### Agrupar indivíduos que foram monitorados entre 28/08 e 01/10 (737, 745, 749, 750, 751, 752) #####################
individuos_28a01 <- c(737, 745, 749, 750, 751, 752)

banco_28a01 <- dados_ordenados %>% 
  filter(IDPerfil %in% individuos_28a01)


# Definindo as datas de limite (de 28/08 a 01/10)
data_limite_inicial28a01 <- as.Date("2023-08-28")
data_limite_final28a01 <- as.Date("2023-10-01")


# Excluindo linhas com datas fora do intervalo
banco_28a01 <- banco_28a01 %>%
  filter(between(Date, data_limite_inicial28a01, data_limite_final28a01))


# Criando uma variável para indicar cada uma das semanas
min_semana <- min(isoweek(banco_28a01$Date))
banco_28a01 <- banco_28a01 %>%
  mutate(semana = isoweek(Date) - min_semana + 1)


#Calculando a quantidade de minutos de AF em cada intensidade, para cada indivíduo em cada semana
banco_28a01 <- banco_28a01 %>%
  group_by(IDPerfil, semana) %>%
  summarise(
    Leve = sum(LeveMin),
    Moderada = sum(ModeradaMin),
    VigorosaS = sum(Vigorosa)
  ) %>%
  pivot_wider(names_from = semana, values_from = c(Leve, Moderada, VigorosaS))


write_xlsx(banco_28a01, "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Terceiro Processamento/FLEEM/Dados de períodos diferentes/dados_28a01.xlsx")


######### Agrupar indivíduos que foram monitorados entre 04/09 e 08/10 (753, 754, 755) #####################
individuos_04a08 <- c(753, 754, 755)

banco_04a08 <- dados_ordenados %>% 
  filter(IDPerfil %in% individuos_04a08)


# Definindo as datas de limite (de 04/09 a 08/10)
data_limite_inicial04a08 <- as.Date("2023-09-04")
data_limite_final04a08 <- as.Date("2023-10-08")


# Excluindo linhas com datas fora do intervalo
banco_04a08 <- banco_04a08 %>%
  filter(between(Date, data_limite_inicial04a08, data_limite_final04a08))


# Criando uma variável para indicar cada uma das semanas
min_semana <- min(isoweek(banco_04a08$Date))
banco_04a08 <- banco_04a08 %>%
  mutate(semana = isoweek(Date) - min_semana + 1)


#Calculando a quantidade de minutos de AF em cada intensidade, para cada indivíduo em cada semana
banco_04a08 <- banco_04a08 %>%
  group_by(IDPerfil, semana) %>%
  summarise(
    Leve = sum(LeveMin),
    Moderada = sum(ModeradaMin),
    VigorosaS = sum(Vigorosa)
  ) %>%
  pivot_wider(names_from = semana, values_from = c(Leve, Moderada, VigorosaS))


write_xlsx(banco_04a08, "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Terceiro Processamento/FLEEM/Dados de períodos diferentes/dados_04a08.xlsx")


######### Agrupar indivíduos que foram monitorados entre 18/09 e 22/10 (756, 757, 758) #####################
individuos_18a22 <- c(756, 757, 758)

banco_18a22 <- dados_ordenados %>% 
  filter(IDPerfil %in% individuos_18a22)


# Definindo as datas de limite (de 18/09 a 22/10)
data_limite_inicial18a22 <- as.Date("2023-09-18")
data_limite_final18a22 <- as.Date("2023-10-22")


# Excluindo linhas com datas fora do intervalo
banco_18a22 <- banco_18a22 %>%
  filter(between(Date, data_limite_inicial18a22, data_limite_final18a22))


# Criando uma variável para indicar cada uma das semanas
min_semana <- min(isoweek(banco_18a22$Date))
banco_18a22 <- banco_18a22 %>%
  mutate(semana = isoweek(Date) - min_semana + 1)


#Calculando a quantidade de minutos de AF em cada intensidade, para cada indivíduo em cada semana
banco_18a22 <- banco_18a22 %>%
  group_by(IDPerfil, semana) %>%
  summarise(
    Leve = sum(LeveMin),
    Moderada = sum(ModeradaMin),
    VigorosaS = sum(Vigorosa)
  ) %>%
  pivot_wider(names_from = semana, values_from = c(Leve, Moderada, VigorosaS))


write_xlsx(banco_18a22, "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Terceiro Processamento/FLEEM/Dados de períodos diferentes/dados_18a22.xlsx")



######### Agrupar indivíduos que foram monitorados entre 06/11 e 10/12 (759, 760, 761) #####################
individuos_06a10 <- c(759, 760, 761)

banco_06a10 <- dados_ordenados %>% 
  filter(IDPerfil %in% individuos_06a10)


# Definindo as datas de limite (de 06/11 a 10/12)
data_limite_inicial06a10 <- as.Date("2023-11-06")
data_limite_final06a10 <- as.Date("2023-12-10")


# Excluindo linhas com datas fora do intervalo
banco_06a10 <- banco_06a10 %>%
  filter(between(Date, data_limite_inicial06a10, data_limite_final06a10))


# Criando uma variável para indicar cada uma das semanas
min_semana <- min(isoweek(banco_06a10$Date))
banco_06a10 <- banco_06a10 %>%
  mutate(semana = isoweek(Date) - min_semana + 1)


#Calculando a quantidade de minutos de AF em cada intensidade, para cada indivíduo em cada semana
banco_06a10 <- banco_06a10 %>%
  group_by(IDPerfil, semana) %>%
  summarise(
    Leve = sum(LeveMin),
    Moderada = sum(ModeradaMin),
    VigorosaS = sum(Vigorosa)
  ) %>%
  pivot_wider(names_from = semana, values_from = c(Leve, Moderada, VigorosaS))


write_xlsx(banco_06a10, "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Terceiro Processamento/FLEEM/Dados de períodos diferentes/dados_06a10.xlsx")



######### Agrupar indivíduos que foram monitorados entre 20/11 e 24/12 (762) #####################
individuos_20a24 <- c(762)

banco_20a24 <- dados_ordenados %>% 
  filter(IDPerfil %in% individuos_20a24)


# Definindo as datas de limite (de 20/11 a 24/12)
data_limite_inicial20a24 <- as.Date("2023-11-20")
data_limite_final20a24 <- as.Date("2023-12-24")


# Excluindo linhas com datas fora do intervalo
banco_20a24 <- banco_20a24 %>%
  filter(between(Date, data_limite_inicial20a24, data_limite_final20a24))


# Criando uma variável para indicar cada uma das semanas
min_semana <- min(isoweek(banco_20a24$Date))
banco_20a24 <- banco_20a24 %>%
  mutate(semana = isoweek(Date) - min_semana + 1)


#Calculando a quantidade de minutos de AF em cada intensidade, para cada indivíduo em cada semana
banco_20a24 <- banco_20a24 %>%
  group_by(IDPerfil, semana) %>%
  summarise(
    Leve = sum(LeveMin),
    Moderada = sum(ModeradaMin),
    VigorosaS = sum(Vigorosa)
  ) %>%
  pivot_wider(names_from = semana, values_from = c(Leve, Moderada, VigorosaS))


write_xlsx(banco_20a24, "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Terceiro Processamento/FLEEM/Dados de períodos diferentes/dados_20a24.xlsx")



######### Agrupar indivíduos que foram monitorados entre 27/11 e 31/12 (763) #####################
individuos_27a31 <- c(763)

banco_27a31 <- dados_ordenados %>% 
  filter(IDPerfil %in% individuos_27a31)


# Definindo as datas de limite (de 27/11 a 31/12)
data_limite_inicial27a31 <- as.Date("2023-11-27")
data_limite_final27a31 <- as.Date("2023-12-31")


# Excluindo linhas com datas fora do intervalo
banco_27a31 <- banco_27a31 %>%
  filter(between(Date, data_limite_inicial27a31, data_limite_final27a31))


# Criando uma variável para indicar cada uma das semanas
min_semana <- min(isoweek(banco_27a31$Date))
banco_27a31 <- banco_27a31 %>%
  mutate(semana = isoweek(Date) - min_semana + 1)


#Calculando a quantidade de minutos de AF em cada intensidade, para cada indivíduo em cada semana
banco_27a31 <- banco_27a31 %>%
  group_by(IDPerfil, semana) %>%
  summarise(
    Leve = sum(LeveMin),
    Moderada = sum(ModeradaMin),
    VigorosaS = sum(Vigorosa)
  ) %>%
  pivot_wider(names_from = semana, values_from = c(Leve, Moderada, VigorosaS))


write_xlsx(banco_27a31, "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Terceiro Processamento/FLEEM/Dados de períodos diferentes/dados_27a31.xlsx")


# Agora vamos concatenar todos os bancos de dados, gerando assim um único banco de dados com todos os sujeitos
banco_concatenado <- rbind(banco_24a29, banco_01a04, banco_08a11, banco_08a11_extendido, banco_15a18, banco_24a27, banco_31a03, banco_07a10, banco_14a17, banco_21a24, banco_28a01, banco_04a08, banco_18a22, banco_06a10, banco_20a24, banco_27a31)


# Agora vamos atribuir IDs aos sujeitos que correspondam aos IDs que utilizamos no banco de dados do IPAQ, para podermos concatenar os dois bancos de dados para análise.
banco_concatenado <- banco_concatenado %>%
  mutate(ID = case_when(
    IDPerfil == "684" ~ 1,
    IDPerfil == "685" ~ 2,
    IDPerfil == "687" ~ 4,
    IDPerfil == "686" ~ 3,
    IDPerfil == "689" ~ 6,
    IDPerfil == "691" ~ 8,
    IDPerfil == "692" ~ 9,
    IDPerfil == "693" ~ 10,
    IDPerfil == "697" ~ 14,
    IDPerfil == "699" ~ 16,
    IDPerfil == "702" ~ 19,
    IDPerfil == "703" ~ 20,
    IDPerfil == "705" ~ 22,
    IDPerfil == "706" ~ 23,
    IDPerfil == "688" ~ 5,
    IDPerfil == "690" ~ 7,
    IDPerfil == "695" ~ 12,
    IDPerfil == "700" ~ 17,
    IDPerfil == "707" ~ 24,
    IDPerfil == "709" ~ 26,
    IDPerfil == "710" ~ 27,
    IDPerfil == "711" ~ 28,
    IDPerfil == "712" ~ 29,
    IDPerfil == "696" ~ 13,
    IDPerfil == "708" ~ 25,
    IDPerfil == "713" ~ 30,
    IDPerfil == "714" ~ 31,
    IDPerfil == "715" ~ 32,
    IDPerfil == "716" ~ 33,
    IDPerfil == "719" ~ 36,
    IDPerfil == "723" ~ 40,
    IDPerfil == "725" ~ 42,
    IDPerfil == "727" ~ 44,
    IDPerfil == "720" ~ 37,
    IDPerfil == "728" ~ 45,
    IDPerfil == "729" ~ 46,
    IDPerfil == "730" ~ 47,
    IDPerfil == "733" ~ 50,
    IDPerfil == "734" ~ 51,
    IDPerfil == "738" ~ 55,
    IDPerfil == "726" ~ 43,
    IDPerfil == "740" ~ 57,
    IDPerfil == "741" ~ 58,
    IDPerfil == "743" ~ 60,
    IDPerfil == "744" ~ 61,
    IDPerfil == "747" ~ 64,
    IDPerfil == "748" ~ 65,
    IDPerfil == "737" ~ 54,
    IDPerfil == "745" ~ 62,
    IDPerfil == "749" ~ 66,
    IDPerfil == "750" ~ 67,
    IDPerfil == "751" ~ 68,
    IDPerfil == "752" ~ 69,
    IDPerfil == "753" ~ 70,
    IDPerfil == "754" ~ 71,
    IDPerfil == "755" ~ 72,
    IDPerfil == "756" ~ 73,
    IDPerfil == "757" ~ 74,
    IDPerfil == "758" ~ 75,
    IDPerfil == "759" ~ 76,
    IDPerfil == "760" ~ 77,
    IDPerfil == "761" ~ 78,
    IDPerfil == "762" ~ 79,
    IDPerfil == "763" ~ 80,
    # Adicione mais casos conforme necessário
    TRUE ~ NA_real_  # Caso padrão, caso IDPERFIL não corresponda a nenhum caso
  ))


write_xlsx(banco_concatenado, "D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Terceiro Processamento/FLEEM/resultado_af_processado.xlsx")
