# Carregar pacotes necessários
library(plyr)
library(statsr)
library(dplyr)
library(ggplot2)
library(readxl)
library(lubridate)
library(writexl)



# Carregar os dados de cada semana
dados_sem1 = read_excel('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Sem nenhum processamento/IPAQ/Respostas extraidas do google forms/Semana_1_(respostas).xlsx')
dados_sem2 = read_excel('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Sem nenhum processamento/IPAQ/Respostas extraidas do google forms/Semana_2_(respostas).xlsx')
dados_sem3 = read_excel('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Sem nenhum processamento/IPAQ/Respostas extraidas do google forms/Semana_3_(respostas).xlsx')
dados_sem4 = read_excel('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Sem nenhum processamento/IPAQ/Respostas extraidas do google forms/Semana_4_(respostas).xlsx')
dados_sem5 = read_excel('D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Sem nenhum processamento/IPAQ/Respostas extraidas do google forms/Semana_5_(respostas).xlsx')


# É notável que alguns conjuntos de dados possuem 38 colunas e outros 35. Vamos remover algumas variáveis desses que possuem 38 para garantir que os bancos de dados sejam equivalentes.
dados_sem2 <- dados_sem2 %>% 
  select(-`Qual é a sua idade?`, -`Qual é o seu sexo biológico?`, -`Qual é o nível de escolaridade mais alto que você obteve até agora?`)

dados_sem3 <- dados_sem3 %>% 
  select(-`Qual é a sua idade?`, -`Qual é o seu sexo biológico?`, -`Qual é o nível de escolaridade mais alto que você obteve até agora?`)


# Criar uma função para renomear as colunas para ficar mais fácil operarmos com os dados
renomear_colunas <- function(dados){

  colnames(dados)[colnames(dados) == "1b - Em quantos dias da semana anterior (últimos 7 dias) você fez atividades VIGOROSAS, POR PELO MENOS 10 MINUTOS CONTÍNUOS, como trabalho de construção pesada, carregar grandes pesos, trabalhar com enxada, escavar ou subir escadas como parte do seu trabalho ou ocupação? (Caso você não tenha feito nenhuma das atividades citadas acima na última semana, coloque 00:00 (zero) na pergunta seguinte e vá para a questão 1d)."] <- "Freq_ocupacional_vig"
  colnames(dados)[colnames(dados) == "1c - Quanto tempo em média você gastou POR DIA (em horas, seguidas de minutos (HORAS:MINUTOS)) fazendo atividades físicas vigorosas como parte do seu trabalho ou ocupação? (Para estimar essa média, pense em quanto tempo normalmente você gastou por dia, na maioria dos dias que fez essas atividades)"] <- "Tempo_ocupacional_vig"
  colnames(dados)[colnames(dados) == "1d - Em quantos dias da semana anterior (últimos 7 dias) você fez atividades MODERADAS, POR PELO MENOS 10 MINUTOS CONTÍNUOS, como carregar pesos leves como parte do seu trabalho ou ocupação? (Caso você não tenha feito nenhuma das atividades citadas acima na última semana, coloque 00:00 (zero) na pergunta seguinte e vá para a questão 1f)."] <- "Freq_ocupacional_mod"
  colnames(dados)[colnames(dados) == "1e - Quanto tempo em média você gastou POR DIA (em horas, seguidas de minutos (HORAS:MINUTOS)) fazendo atividades moderadas como parte do seu trabalho ou ocupação? (Para estimar essa média, pense em quanto tempo normalmente você gastou por dia, na maioria dos dias que fez essas atividades)"] <- "Tempo_ocupacional_mod"
  colnames(dados)[colnames(dados) == "1f - Em quantos dias da semana anterior (últimos 7 dias) você ANDOU, durante PELO MENOS 10 MINUTOS CONTÍNUOS, como parte do seu trabalho ou ocupação? Por favor, NÃO inclua o andar como forma de transporte para ir ou voltar do trabalho ou ocupação (Caso você não tenha andando na última semana, como parte do seu trabalho ou ocupação, coloque 00:00 (zero) na pergunta seguinte e vá para a questão 1d)."] <- "Freq_ocupacional_cam"
  colnames(dados)[colnames(dados) == "1g - Quanto tempo em média você gastou POR DIA (em horas, seguidas de minutos (HORAS:MINUTOS)) caminhando como parte do seu trabalho ou ocupação? (Para estimar essa média, pense em quanto tempo normalmente você gastou por dia, na maioria dos dias que fez essas atividades)"] <- "Tempo_ocupacional_cam"
  colnames(dados)[colnames(dados) == "2a - Em quantos dias da última semana (últimos 7 dias) você andou de carro, ônibus, metrô ou trem? (Caso você não tenha utilizado nenhum destes meios de transporte na última semana, coloque 00:00 (zero) na pergunta seguinte e vá para a questão 2c)."] <- "Freq_carro"
  colnames(dados)[colnames(dados) == "2b - Quanto tempo em média você gastou POR DIA (em horas, seguidas de minutos (HORAS:MINUTOS)) andando de carro, ônibus, metrô ou trem? (Para estimar essa média, pense em quanto tempo normalmente você gastou por dia, na maioria dos dias que andou nesses meios de transporte)"] <- "Tempo_carro"
  colnames(dados)[colnames(dados) == "2c - Em quantos dias da última semana (últimos 7 dias) você andou de bicicleta por PELO MENOS 10 MINUTOS CONTÍNUOS para ir de um lugar para outro? (NÃO inclua o pedalar por lazer ou exercício, e caso não tenha andado de bicicleta para ir de um lugar ao outro nos últimos 7 dias, marque 00:00 (zero) na questão seguinte e vá para a 2e)"] <- "Freq_bike"
  colnames(dados)[colnames(dados) == "2d - Nos dias que você pedalou, quanto tempo em média você pedalou POR DIA (em horas, seguidas de minutos (HORAS:MINUTOS)) para ir de um lugar para outro? (Para estimar essa média, pense em quanto tempo normalmente você gastou por dia, na maioria dos dias que você pedalou)"] <- "Tempo_bike"
  colnames(dados)[colnames(dados) == "2e - Em quantos dias da última semana (últimos 7 dias) você caminhou por PELO MENOS 10 MINUTOS CONTÍNUOS para ir de um lugar para outro? (NÃO inclua as caminhadas por lazer ou exercício, e caso não tenha caminhado para ir de um lugar ao outro nos últimos 7 dias, marque 00:00 (zero) na questão seguinte e vá para a seção 3)"] <- "Freq_caminhada"
  colnames(dados)[colnames(dados) == "2f - Quando você caminhou para ir de um lugar para outro, quanto tempo em média você gastou POR DIA (em horas, seguidas de minutos (HORAS:MINUTOS))? (Para estimar essa média, pense em quanto tempo normalmente você gastou por dia, na maioria dos dias que você caminhou)"] <- "Tempo_caminhada"
  colnames(dados)[colnames(dados) == "3a - Em quantos dias da última semana (últimos 7 dias) você fez atividades VIGOROSAS no jardim ou quintal por pelo menos 10 minutos como carpir, lavar o quintal, esfregar o chão? (Caso você não tenha feito nenhuma dessas atividades, coloque 00:00 (zero) na pergunta seguinte e vá para a questão 3c)."] <- "Freq_vig_jardim"  
  colnames(dados)[colnames(dados) == "3b - Nos dias que você fez este tipo de atividades vigorosas no quintal ou jardim, quanto tempo em média você gastou POR DIA (em horas, seguidas de minutos (HORAS:MINUTOS))? (Para estimar essa média, pense em quanto tempo normalmente você gastou por dia, na maioria dos dias que fez essas atividades)"] <- "Tempo_vig_jardim"  
  colnames(dados)[colnames(dados) == "3c - Em quantos dias da semana anterior (últimos 7 dias) você fez atividades MODERADAS por pelo menos 10 minutos como carregar pesos leves, limpar vidros ou varrer, no jardim ou quintal? (Caso você não tenha feito nenhuma dessas atividades, coloque 00:00 (zero) na pergunta seguinte e vá para a questão 3e)."] <- "Freq_mod_jardim"
  colnames(dados)[colnames(dados) == "3d - Nos dias que você fez este tipo de atividades, quanto tempo em média você gastou POR DIA (em horas, seguidas de minutos (HORAS:MINUTOS)) fazendo essas atividades moderadas no jardim ou quintal? (Para estimar essa média, pense em quanto tempo normalmente você gastou por dia, na maioria dos dias que fez essas atividades)"] <- "Tempo_mod_jardim"  
  colnames(dados)[colnames(dados) == "3e - Em quantos dias da última semana (últimos 7 dias) você fez atividades MODERADAS por pelo menos 10 minutos como carregar pesos leves, limpar vidros, varrer ou limpar o chão dentro da sua casa? (Caso você não tenha feito nenhuma dessas atividades, coloque 00:00 (zero) na pergunta seguinte e vá para a seção 4)."] <- "Freq_mod_casa"    
  colnames(dados)[colnames(dados) == "3f - Nos dias que você fez este tipo de atividades moderadas dentro da sua casa, quanto tempo em média você gastou POR DIA (em horas, seguidas de minutos (HORAS:MINUTOS))? (Para estimar essa média, pense em quanto tempo normalmente você gastou por dia, na maioria dos dias que fez essas atividades)"] <- "Tempo_mod_casa"  
  colnames(dados)[colnames(dados) == "4a - SEM CONTAR QUALQUER CAMINHADA QUE VOCÊ TENHA CITADO ANTERIORMENTE, em quantos dias da semana anterior (últimos 7 dias) você caminhou POR PELO MENOS 10 MINUTOS CONTÍNUOS no seu tempo livre? (Caso você não tenha caminhado no seu tempo livre, responda 00:00 (zero) na questão seguinte e vá para a questão 4c)."] <- "Freq_cam_lazer"  
  colnames(dados)[colnames(dados) == "4b - Nos dias em que você caminhou NO SEU TEMPO LIVRE, quanto tempo em média você gastou POR DIA (em horas, seguidas de minutos (HORAS:MINUTOS))? (Para estimar essa média, pense em quanto tempo normalmente você gastou por dia, na maioria dos dias que você caminhou NO SEU TEMPO LIVRE)"] <- "Tempo_cam_lazer"  
  colnames(dados)[colnames(dados) == "4c - Em quantos dias da semana anterior (últimos 7 dias), você fez atividades VIGOROSAS NO SEU TEMPO LIVRE por pelo menos 10 minutos, como correr, fazer exercícios aeróbios, nadar rápido, pedalar rápido ou fazer jogging? (Caso você não tenha feito nenhuma atividade VIGOROSA no seu tempo livre nos últimos 7 dias, marque 00:00 (zero) na questão seguinte e vá para a questão 4e)."] <- "Freq_vig_lazer"  
  colnames(dados)[colnames(dados) == "4d - Nos dias em que você fez estas atividades vigorosas no seu tempo livre quanto tempo em média você gastou POR DIA (em horas, seguidas de minutos (HORAS:MINUTOS))? (Para estimar essa média, pense em quanto tempo normalmente você gastou por dia, na maioria dos dias que fez essas atividades)"] <- "Tempo_vig_lazer"  
  colnames(dados)[colnames(dados) == "4e - Em quantos dias da semana anterior (últimos 7 dias) você fez atividades MODERADAS NO SEU TEMPO LIVRE por pelo menos 10 minutos, como pedalar ou nadar a velocidade regular, jogar bola, vôlei, basquete ou tênis? (Caso você não tenha feito nenhuma atividade MODERADA no seu tempo livre nos últimos 7 dias, marque 00:00 (zero) na questão seguinte e vá para a seção 5)."] <- "Freq_mod_lazer"  
  colnames(dados)[colnames(dados) == "4f - Nos dias em que você fez estas atividades moderadas no seu tempo livre quanto tempo em média você gastou POR DIA (em horas, seguidas de minutos (HORAS:MINUTOS))? (Para estimar essa média, pense em quanto tempo normalmente você gastou por dia, na maioria dos dias que fez essas atividades)"] <- "Tempo_mod_lazer"  
  colnames(dados)[colnames(dados) == "5a - Quanto tempo em média você gastou sentado durante um DIA DE SEMANA (em horas, seguidas de minutos (HORAS:MINUTOS))? (Para estimar essa média, pense em quanto tempo normalmente você passou sentado por dia, na maioria dos dias em que se manteve sentado)"] <- "Tempo_sentado_semana"  
  colnames(dados)[colnames(dados) == "5b - Quanto tempo em média você gastou sentado durante um DIA DE FINAL DE SEMANA (em horas, seguidas de minutos (HORAS:MINUTOS))? (Para estimar essa média, pense em quanto tempo normalmente você passou sentado em um dia de final de semana, na maioria dos dias de final de semana que se manteve sentado)"] <- "Tempo_sentado_fds"  
  
  
  return(dados)
  
  }

# Aplicar a função nos conjuntos de dados
dados_sem1 <- renomear_colunas(dados_sem1)
dados_sem2 <- renomear_colunas(dados_sem2)
dados_sem3 <- renomear_colunas(dados_sem3)
dados_sem4 <- renomear_colunas(dados_sem4)
dados_sem5 <- renomear_colunas(dados_sem5)

# Criar uma função para remover variáveis que não serão utilizadas no processamento
remover_variaveis <- function(dados){
  
  select(dados, -2, -3, -5, -6, -7, -8, -9)
  
}


# Aplicar a função nos dados
dados_sem1 <- remover_variaveis(dados_sem1)
dados_sem2 <- remover_variaveis(dados_sem2)
dados_sem3 <- remover_variaveis(dados_sem3)
dados_sem4 <- remover_variaveis(dados_sem4)
dados_sem5 <- remover_variaveis(dados_sem5)


# Os dados de data precisam ser convertidos para o formato H:M:S, portanto, faremos isso por meio de uma função
extrair_horas <- function(dados){
  dados$Tempo_ocupacional_vig <- format(dados$Tempo_ocupacional_vig, "%H:%M:%S")
  dados$Tempo_ocupacional_mod <- format(dados$Tempo_ocupacional_mod, "%H:%M:%S")
  dados$Tempo_ocupacional_cam <- format(dados$Tempo_ocupacional_cam, "%H:%M:%S")
  dados$Tempo_carro <- format(dados$Tempo_carro, "%H:%M:%S")
  dados$Tempo_bike <- format(dados$Tempo_bike, "%H:%M:%S")
  dados$Tempo_caminhada <- format(dados$Tempo_caminhada, "%H:%M:%S")
  dados$Tempo_vig_jardim <- format(dados$Tempo_vig_jardim, "%H:%M:%S")
  dados$Tempo_mod_jardim <- format(dados$Tempo_mod_jardim, "%H:%M:%S")
  dados$Tempo_mod_casa <- format(dados$Tempo_mod_casa, "%H:%M:%S")
  dados$Tempo_cam_lazer <- format(dados$Tempo_cam_lazer, "%H:%M:%S")
  dados$Tempo_vig_lazer <- format(dados$Tempo_vig_lazer, "%H:%M:%S")
  dados$Tempo_mod_lazer <- format(dados$Tempo_mod_lazer, "%H:%M:%S")
  dados$Tempo_sentado_semana <- format(dados$Tempo_sentado_semana, "%H:%M:%S")
  dados$Tempo_sentado_fds <- format(dados$Tempo_sentado_fds, "%H:%M:%S")
  
  return(dados)
}

# Aplicar a função de extrair as horas nos dados de todas as semanas
dados_sem1 <- extrair_horas(dados_sem1)
dados_sem2 <- extrair_horas(dados_sem2)
dados_sem3 <- extrair_horas(dados_sem3)
dados_sem4 <- extrair_horas(dados_sem4)
dados_sem5 <- extrair_horas(dados_sem5)


# Agora precisamos converter as horas em minutos. Para isso, primeiro definiremos uma função que converte as horas em minutos para ser aplicada à cada coluna de tempo do banco de dados
converter_tempo_para_minutos <- function(coluna_tempo) {
  segundos <- period_to_seconds(hms(coluna_tempo))
  minutos <- segundos / 60
  return(minutos)
}



# Agora vamos criar uma função composta, para conseguir aplicar a função de conversão de tempo em todos os bancos de dados
converter_tempo_para_minutos_bd <- function(dados){
  
  dados$Tempo_ocupacional_vig_min <- converter_tempo_para_minutos(dados$Tempo_ocupacional_vig)
  dados$Tempo_ocupacional_mod_min <- converter_tempo_para_minutos(dados$Tempo_ocupacional_mod)
  dados$Tempo_ocupacional_cam_min <- converter_tempo_para_minutos(dados$Tempo_ocupacional_cam)
  dados$Tempo_carro_min <- converter_tempo_para_minutos(dados$Tempo_carro)
  dados$Tempo_bike_min <- converter_tempo_para_minutos(dados$Tempo_bike)
  dados$Tempo_caminhada_min <- converter_tempo_para_minutos(dados$Tempo_caminhada)
  dados$Tempo_vig_jardim_min <- converter_tempo_para_minutos(dados$Tempo_vig_jardim)
  dados$Tempo_mod_jardim_min <- converter_tempo_para_minutos(dados$Tempo_mod_jardim)
  dados$Tempo_mod_casa_min <- converter_tempo_para_minutos(dados$Tempo_mod_casa)
  dados$Tempo_cam_lazer_min <- converter_tempo_para_minutos(dados$Tempo_cam_lazer)
  dados$Tempo_vig_lazer_min <- converter_tempo_para_minutos(dados$Tempo_vig_lazer)
  dados$Tempo_mod_lazer_min <- converter_tempo_para_minutos(dados$Tempo_mod_lazer)
  dados$Tempo_sentado_semana_min <- converter_tempo_para_minutos(dados$Tempo_sentado_semana)
  dados$Tempo_sentado_fds_min <- converter_tempo_para_minutos(dados$Tempo_sentado_fds)
  
  
  return(dados)
}


# Aplicar a função nos bancos de dados para criar a coluna com as variáveis em minutos
dados_sem1 <- converter_tempo_para_minutos_bd(dados_sem1)
dados_sem2 <- converter_tempo_para_minutos_bd(dados_sem2)
dados_sem3 <- converter_tempo_para_minutos_bd(dados_sem3)
dados_sem4 <- converter_tempo_para_minutos_bd(dados_sem4)
dados_sem5 <- converter_tempo_para_minutos_bd(dados_sem5)


# Agora vamos construir outra função, agora para remover os dados de horas, mantendo assim somente os minutos no banco de dados
remover_var_horas <- function(dados){
  
  select(dados, -4, -6, -8, -10, -12, -14, -16, -18, -20, -22, -24, -26, -27, -28)
  

}


# Aplicar a função em todos os bancos de dados
dados_sem1 <- remover_var_horas(dados_sem1)
dados_sem2 <- remover_var_horas(dados_sem2)
dados_sem3 <- remover_var_horas(dados_sem3)
dados_sem4 <- remover_var_horas(dados_sem4)
dados_sem5 <- remover_var_horas(dados_sem5)



# Agora vamos verificar se existem possíveis outliers nos dados, seguindo as recomendações de processamento de: INSIRA AQUI A REF

verificar_outliers <- function(dados){
  
  # Primeiro, definir a quantidade de horas diárias reportadas pelo sujeito, como a soma de todas as tarefas diárias reportadas
  dados$Atividade_diaria_total = dados$Tempo_ocupacional_vig_min + dados$Tempo_ocupacional_mod_min + dados$Tempo_ocupacional_cam_min + dados$Tempo_carro_min + dados$Tempo_bike_min + dados$Tempo_caminhada_min + dados$Tempo_vig_jardim_min + dados$Tempo_mod_jardim_min + dados$Tempo_mod_casa_min + dados$Tempo_cam_lazer_min + dados$Tempo_vig_lazer_min + dados$Tempo_mod_lazer_min 
  
  
  # Agora vamos verificar se esse valor é plausível, assumindo que cada indivíduo dorme pelo menos 8 horas por noite, a soma total das demais tarefas não pode ultrapassar 16 horas (960 minutos)
  dados$outlier <- ifelse(dados$Atividade_diaria_total > 960, 1, 0)
    
  return(dados)
  
}


# Agora vamos aplicar a função nos dados de cada semana
dados_sem1 <- verificar_outliers(dados_sem1)
dados_sem2 <- verificar_outliers(dados_sem2)
dados_sem3 <- verificar_outliers(dados_sem3)
dados_sem4 <- verificar_outliers(dados_sem4)
dados_sem5 <- verificar_outliers(dados_sem5)


# Agora vamos construir uma função para quantificar os minutos de atividade física de cada intensidade e domínio por semana
processar_ipaq <- function(dados){
  
  
  # Extrair o número da string usando expressão regular
  semana <- as.numeric(gsub("\\D", "", dados))
  
  
  # Vamos quantificar a quantidade de minutos para cada domínio e intensidade, multiplicando a frequência autorrelatada pelo tempo autorrelatado em minutos
  dados$Ocupacional_vig <- dados$Freq_ocupacional_vig * dados$Tempo_ocupacional_vig_min
  dados$Ocupacional_mod <- dados$Freq_ocupacional_mod * dados$Tempo_ocupacional_mod_min
  dados$Ocupacional_cam <- dados$Freq_ocupacional_cam * dados$Tempo_ocupacional_cam_min
  dados$Carro <- dados$Freq_carro * dados$Tempo_carro_min
  dados$Bike <- dados$Freq_bike * dados$Tempo_bike_min
  dados$Caminhada <- dados$Freq_caminhada * dados$Tempo_caminhada_min
  dados$Jardim_vig <- dados$Freq_vig_jardim * dados$Tempo_vig_jardim_min
  dados$Jardim_mod <- dados$Freq_mod_jardim * dados$Tempo_mod_jardim_min
  dados$Casa_mod <- dados$Freq_mod_casa * dados$Tempo_mod_casa_min
  dados$Cam_lazer <- dados$Freq_cam_lazer * dados$Tempo_cam_lazer_min
  dados$Vig_lazer <- dados$Freq_vig_lazer * dados$Tempo_vig_lazer_min
  dados$Mod_lazer <- dados$Freq_mod_lazer * dados$Tempo_mod_lazer_min
  
  
  # Vamos quantificar a quantidade semanal por intensidade
  dados$Caminhada_total <- dados$Ocupacional_cam + dados$Caminhada + dados$Cam_lazer
  dados$Moderada <- dados$Ocupacional_mod + dados$Bike + dados$Jardim_mod + dados$Casa_mod + dados$Mod_lazer
  dados$Vigorosa <- dados$Ocupacional_vig + dados$Jardim_vig + dados$Vig_lazer
  
  # Agora vamos quantificar a quantidade semanal de AF em cada domínio
  dados$Atividade_ocupacional <- dados$Ocupacional_vig + dados$Ocupacional_mod + dados$Ocupacional_cam
  dados$Atividade_transporte <- dados$Carro + dados$Bike + dados$Caminhada
  dados$Atividade_domestica <- dados$Jardim_vig + dados$Jardim_mod + dados$Casa_mod
  dados$Atividade_lazer <- dados$Cam_lazer + dados$Vig_lazer + dados$Mod_lazer
  
  
  
  return(dados)
}


# Agora vamos aplicar a função em todos os bancos de dados
dados_sem1 <- processar_ipaq(dados_sem1)
dados_sem2 <- processar_ipaq(dados_sem2)
dados_sem3 <- processar_ipaq(dados_sem3)
dados_sem4 <- processar_ipaq(dados_sem4)
dados_sem5 <- processar_ipaq(dados_sem5)



# Vamos novamente filtrar os dados, agora mantendo somente as quantidades semanais. Para isso, vamos usar outra função
ultimo_filtro <- function(dados){
  
  
  select(dados, -c(2:26))
  
  
}


# Agora vamos aplicar esse último filtro nos dados, restando os dados que faremos a concatenação dos bancos de dados
dados_sem1 <- ultimo_filtro(dados_sem1)
dados_sem2 <- ultimo_filtro(dados_sem2)
dados_sem3 <- ultimo_filtro(dados_sem3)
dados_sem4 <- ultimo_filtro(dados_sem4)
dados_sem5 <- ultimo_filtro(dados_sem5)



# Agora vamos juntar os bancos de dados em apenas 1
dados_semanas <- dados_sem1 %>%
  left_join(dados_sem2, by = ('ID')) 

dados_semanas <- dados_semanas %>%
  left_join(dados_sem3, by = ('ID'))


dados_semanas <- dados_semanas %>%
  left_join(dados_sem4, by = ('ID'))


dados_semanas <- dados_semanas %>%
  left_join(dados_sem5, by = ('ID'))


# Vamos criar uma variável para computar possíveis outliers
dados_semanas$Outliers <- dados_semanas$outlier + dados_semanas$outlier.x + dados_semanas$outlier.x.x + dados_semanas$outlier.y + dados_semanas$outlier.y.y


# Agora vamos salvar o banco de dados para podermos analisá-lo
write_xlsx(dados_semanas,"D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Primeiro processamento/IPAQ/dados_semanas.xlsx")
