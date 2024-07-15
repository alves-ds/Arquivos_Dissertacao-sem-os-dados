install.packages("metafor")

# Carregue a biblioteca 'metafor'
library(metafor)
library(readxl)

# Vamos carregar os diferentes bancos de dados que utilizarem

# Banco 1 - Estudos encontrados e que foram conduzidos com adultos. Utilizaram como medida de confiabilidade o ICC ou correlação de Spearman. 
dados1 <- read_excel('evidencias_consistencia_apenas_ipaq_long_organizado_todos_estudos_somente_adultos.xlsx')

# Banco 2 - Estudos encontrados e que foram conduzidos com adultos. Utilizaram como medida de confiabilidade o ICC. 
dados2 <- read_excel('evidencias_consistencia_apenas_ipaq_long_organizado_todos_estudos_somente_adultos_e_com_icc.xlsx')

# Banco 3 - Estudos encontrados e que foram conduzidos com adultos. Utilizaram como medida de confiabilidade o ICC e se pautaram em um intervalo entre as coletas de 7 dias (mais próximo o possível do meu estudo)
dados3 <- read_excel('evidencias_consistencia_apenas_ipaq_long_organizado_todos_estudos_somente_adultos_e_com_icc_7dias_intervalo.xlsx')


# Agora, vamos criar uma função para transformar os dados do ICC em dados numéricos, pois por padrão estão como strings.
processar_dados <- function(dados){
  dados$Caminhada <- as.numeric(dados$Caminhada)
  dados$Moderada <- as.numeric(dados$Moderada)
  dados$Vigorosa <- as.numeric(dados$Vigorosa)
  
  return(dados)
  
}

# Agora vamos aplicar a função nos nossos dados
dados1 <- processar_dados(dados1)
dados2 <- processar_dados(dados2)
dados3 <- processar_dados(dados3)



# Agora vamos construir nossos forest plot
# Análises só para visualizar os ICCs em conjunto, sem ponderar pela variância ou diferença do N amostral (dado que os estudos não reportam o erro associado ao ICC)

# Realize a meta-análise de efeitos fixos

# Para todas as metanálises, vamos assumir um erro padrão para a estimativa de confiabilidade de 0.0001, tendo em vista que a maioria dos estudos não reportam uma estimativa de incerteza associada às estimativas de confiabilidade. Neste sentido, os forest plots gerados não serão ponderados pela variabilidade das estimativas de cada estudo. 

# Pensar na possibilidade de usar o DP dos ICCs como uma estimativa de erro padrão

# Dados 1
data1_caminhada <- rma(yi = Caminhada, sei = 0.0001, data = dados1, method = "FE")
data1_moderada <- rma(yi = Moderada, sei = 0.0001, data = dados1, method = "FE")
data1_vigorosa <- rma(yi = Vigorosa, sei = 0.0001, data = dados1, method = "FE")

# Dados 2
data2_caminhada <- rma(yi = Caminhada, sei = 0.0001, data = dados2, method = "FE")
data2_moderada <- rma(yi = Moderada, sei = 0.0001, data = dados2, method = "FE")
data2_vigorosa <- rma(yi = Vigorosa, sei = 0.0001, data = dados2, method = "FE")

# Dados 3
data3_caminhada <- rma(yi = Caminhada, sei = 0.0001, data = dados3, method = "FE")
data3_moderada <- rma(yi = Moderada, sei = 0.0001, data = dados3, method = "FE")
data3_vigorosa <- rma(yi = Vigorosa, sei = 0.0001, data = dados3, method = "FE")


# Agora vamos visualizar os forest plot para cada conjunto de dados e desfecho

# Dados 1
forest_data1_caminhada <- forest(data1_caminhada, slab = dados1$Estudo, col = "blue", refline = FALSE, addfit = TRUE, cex = 0.9, header=c("Autor e ano", "Estimativa [95% IC]"), psize=1, xlab = "ICC médio", mlab="Modelo de efeitos fixos", cex.lab=0.65)
forest_data1_moderada <- forest(data1_moderada, slab = dados1$Estudo, ilab = dados1$Moderada, col = "blue", refline = FALSE, addfit = TRUE, cex = 0.9, header=c("Autor e ano", "Estimativa [95% IC]"), psize=1, xlab = "ICC médio", mlab="Modelo de efeitos fixos", cex.lab=0.65)
forest_data1_vigorosa <- forest(data1_vigorosa, slab = dados1$Estudo, ilab = dados1$Vigorosa, col = "blue", refline = FALSE, addfit = TRUE, cex = 0.9, header=c("Autor e ano", "Estimativa [95% IC]"), psize=1, xlab = "ICC médio", mlab="Modelo de efeitos fixos", cex.lab=0.65)


# Dados 2
forest_data2_caminhada <- forest(data2_caminhada, slab = dados2$Estudo, ilab = dados2$Caminhada, col = "blue", refline = FALSE, addfit = TRUE, cex = 0.9, header=c("Autor e ano", "Estimativa [95% IC]"), psize=1, xlab = "ICC médio", mlab="Modelo de efeitos fixos", cex.lab=0.65)
forest_data2_moderada <- forest(data2_moderada, slab = dados2$Estudo, ilab = dados2$Moderada, col = "blue", refline = FALSE, addfit = TRUE, cex = 0.9, header=c("Autor e ano", "Estimativa [95% IC]"), psize=1, xlab = "ICC médio", mlab="Modelo de efeitos fixos", cex.lab=0.65)
forest_data2_vigorosa <- forest(data2_vigorosa, slab = dados2$Estudo, ilab = dados2$Vigorosa, col = "blue", refline = FALSE, addfit = TRUE, cex = 0.9, header=c("Autor e ano", "Estimativa [95% IC]"), psize=1, xlab = "ICC médio", mlab="Modelo de efeitos fixos", cex.lab=0.65)


# Dados 3
forest_data3_caminhada <- forest(data3_caminhada, slab = dados3$Estudo, ilab = dados3$Caminhada, col = "blue", refline = FALSE, addfit = TRUE, cex = 0.9, header=c("Autor e ano", "Estimativa [95% IC]"), psize=1, xlab = "ICC médio", mlab="Modelo de efeitos fixos", cex.lab=0.65)
forest_data3_moderada <- forest(data3_moderada, slab = dados3$Estudo, ilab = dados3$Moderada, col = "blue", refline = FALSE, addfit = TRUE, cex = 0.9, header=c("Autor e ano", "Estimativa [95% IC]"), psize=1, xlab = "ICC médio", mlab="Modelo de efeitos fixos", cex.lab=0.65)
forest_data3_vigorosa <- forest(data3_vigorosa, slab = dados3$Estudo, ilab = dados3$Vigorosa, col = "blue", refline = FALSE, addfit = TRUE, cex = 0.9, header=c("Autor e ano", "Estimativa [95% IC]"), psize=1, xlab = "ICC médio", mlab="Modelo de efeitos fixos", cex.lab=0.65)



# inicializar o FP1
png("forestplot_cam.png", width = 2500, height = 1100, res = 300)
par(mar = c(5, 5, 2, 5))
par(pin = c(6, 6))
forest_data3_caminhada <- forest(data3_caminhada, slab = dados3$Estudo, col = "blue", refline = FALSE, addfit = TRUE, cex = 0.9, header=c("Autor e ano", "Estimativa [95% IC]"), psize=1, xlab = "ICC médio", mlab="Modelo de efeitos fixos", cex.lab=0.8)
# save plot
dev.off()

# inicializar o FP1
png("forestplot_mod.png", width = 2500, height = 1100, res = 300)
par(mar = c(5, 5, 2, 5))
par(pin = c(6, 6))
forest_data3_moderada <- forest(data3_moderada, slab = dados3$Estudo, col = "blue", refline = FALSE, addfit = TRUE, cex = 0.9, header=c("Autor e ano", "Estimativa [95% IC]"), psize=1, xlab = "ICC médio", mlab="Modelo de efeitos fixos", cex.lab=0.65)
# save plot
dev.off()


png("forestplot_vig.png", width = 2500, height = 1100, res = 300)
par(mar = c(5, 5, 2, 5))
par(pin = c(6, 6))
forest_data3_vigorosa <- forest(data3_vigorosa, slab = dados3$Estudo, col = "blue", refline = FALSE, addfit = TRUE, cex = 0.9, header=c("Autor e ano", "Estimativa [95% IC]"), psize=1, xlab = "ICC médio", mlab="Modelo de efeitos fixos", cex.lab=0.65)
# save plot
dev.off()


