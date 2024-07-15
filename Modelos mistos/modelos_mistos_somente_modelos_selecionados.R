# Neste arquivo estão os modelos mistos que foram selecionados dentre aqueles que foram construídos. 
# Optei por colocá-los em um arquivo separado para ficar mais organizado, e para que eu pudesse colocar análises adicionais (tais como os testes post-hoc e afins)


# Para verificar todos os modelos que foram construídos, vamos carregar a tabela na qual eles estão descritos
modelos_construidos <- read_excel("D:/Projeto_mestrado/Dissertacao/MastersDissertation/Modelos mistos/modelos_construidos.xlsx")

# Vamos dar uma olhada em todos os modelos que foram construídos (para ficar mais claro o motivo de eu dividir em um script específico para os que foram escolhidos)
View(modelos_construidos)


# Vamos baixar os pacotes necessário para as análises, caso não os tenhamos
install.packages('lme4')
install.packages("emmeans")

# Caso dê algum conflito para carregar o pacote "Matrix", podemos fazer isso manualmente com o seguinte comando:
remove.packages("Matrix")
install.packages("Matrix")

# Vamos instalar também um pacote para gerarmos gráficos simples quanto aos resultados obtidos
install.packages("sjPlot")
install.packages("glmmTMB")


# Vamos carregar nossos pacotes
library(statsr)
library(dplyr)
library(ggplot2)
library(readxl)
library(lubridate)
library(tidyr)
library(writexl)
library(kableExtra)
library(knitr)
library(lme4)
library(emmeans)

# Vamos carregar um pacote adicional, para os nossos modelos mistos exibirem os valores de p atrelados aos testes de hipótese
library(lmerTest)

# Vamos carregar um pacote para gerar gráficos simples dos efeitos fixos
library(sjPlot)



# Agora vamos carregar os bancos de dados necessários para as análises
# Banco de dados sem remoção de outliers, para os modelos 7, 9 e 11, que foram construídos com os dados obtidos através do FLEEM SYSTEM
dados1 <- read_excel("D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Quinto processamento/banco_dados_reestruturado.xlsx")

# Podemos ver que a variável "semana" está definida como uma variável numérica. Portanto, vamos convertê-la em fator
dados1$Semana <- as.factor(dados1$Semana)


# Agora vamos rodar as nossas análises

# Modelo 7 (aceleração do centro de massa de intensidade leve)

modelo_FLEEM_leve1 <- lmer(Leve_FLEEM ~ Semana + (1 | ID), data = dados1, na.action = na.exclude)
AIC_modelo_FLEEM_leve1 <- AIC(modelo_FLEEM_leve1) #Extrai o AIC do modelo
BIC(modelo_FLEEM_leve1) # Extrai o BIC do modelo
qqnorm(residuals(modelo_FLEEM_leve1)); qqline(residuals(modelo_FLEEM_leve1)) # Plot para verificarmos o ajuste dos resíduos do modelo

# Vamos calcular o ICC, para ver o quanto os sujeitos explicam a variância do modelo

# Vamos primeiro extrair as variâncias atribuídas aos sujeitos, e a residual
var_ID_fleem_leve <- VarCorr(modelo_FLEEM_leve1)$ID
var_residual_fleem_leve <- sigma(modelo_FLEEM_leve1)^2

# Agora vamos calcular o ICC propriamente dito
ICC_modelo_leve_fleem <- var_ID_fleem_leve/(var_ID_fleem_leve+var_residual_fleem_leve)

# Vamos verificar um resumo do nosso modelo, com a função summary()
summary(modelo_FLEEM_leve1)

# Esse pacote não exibe o efeito principal do nosso modelo, portanto, teremos que extrair isso usando a função anova()
anova(modelo_FLEEM_leve1)

# As linhas acima não são suficientes para termos acesso à um teste posthoc, portanto, realizaremos isso de outra maneira
# Primeiro, vamos extrair as médias estimadas e realizar comparações
medias_emmeans_fleem_leve <- emmeans(modelo_FLEEM_leve1, ~ Semana)

# Agora, vamos comparar todas as médias entre si
comparacoes_fleem_leve <- pairs(medias_emmeans_fleem_leve)

# Agora vamos exibir as comparações
print(comparacoes_fleem_leve)

# Vamos gerar um gráfico simples para visualizar nosso efeito fixo
sjPlot::plot_model(modelo_FLEEM_leve1, type = "eff", terms = "Semana")


# Agora vamos repetir esses passos para os demais modelos, então as descrições vão ficar bem repetitivas


# Modelo 9 (aceleração do centro de massa de intensidade moderada)

modelo_FLEEM_moderada1 <- lmer(Moderada_FLEEM_10 ~ Semana + (1 | ID), data = dados1, na.action = na.exclude)
AIC_modelo_FLEEM_moderada1 <- AIC(modelo_FLEEM_moderada1) #Extrai o AIC do modelo
BIC(modelo_FLEEM_moderada1) # Extrai o BIC do modelo
qqnorm(residuals(modelo_FLEEM_moderada1)); qqline(residuals(modelo_FLEEM_moderada1)) # Plot para verificarmos o ajuste dos resíduos do modelo


# Vamos calcular o ICC, para ver o quanto os sujeitos explicam a variância do modelo

# Vamos primeiro extrair as variâncias atribuídas aos sujeitos, e a residual
var_ID_fleem_moderada <- VarCorr(modelo_FLEEM_moderada1)$ID
var_residual_fleem_moderada <- sigma(modelo_FLEEM_moderada1)^2

# Agora vamos calcular o ICC propriamente dito
ICC_modelo_moderada_fleem <- var_ID_fleem_moderada/(var_ID_fleem_moderada+var_residual_fleem_moderada)

# Vamos verificar um resumo do nosso modelo, com a função summary()
summary(modelo_FLEEM_moderada1)

# Esse pacote não exibe o efeito principal do nosso modelo, portanto, teremos que extrair isso usando a função anova()
anova(modelo_FLEEM_moderada1)

# As linhas acima não são suficientes para termos acesso à um teste posthoc, portanto, realizaremos isso de outra maneira
# Primeiro, vamos extrair as médias estimadas e realizar comparações
medias_emmeans_fleem_moderada <- emmeans(modelo_FLEEM_moderada1, ~ Semana)

# Agora, vamos comparar todas as médias entre si
comparacoes_fleem_moderada <- pairs(medias_emmeans_fleem_moderada)

# Agora vamos exibir as comparações
print(comparacoes_fleem_moderada)

# Vamos gerar um gráfico simples para visualizar nosso efeito fixo
sjPlot::plot_model(modelo_FLEEM_moderada1, type = "eff", terms = "Semana")


# Modelo 11 (aceleração do centro de massa de intensidade vigorosa)

modelo_FLEEM_vigorosa1 <- lmer(Vigorosa_FLEEM_10 ~ Semana + (1| ID), data = dados1, na.action = na.exclude)
AIC_modelo_FLEEM_vigorosa1 <- AIC(modelo_FLEEM_vigorosa1) # Extrai o AIC do modelo
BIC(modelo_FLEEM_vigorosa1) # Extrai o BIC do modelo
qqnorm(residuals(modelo_FLEEM_vigorosa1)); qqline(residuals(modelo_FLEEM_vigorosa1)) # Plot para verificarmos o ajuste dos resíduos do modelo


# Vamos calcular o ICC, para ver o quanto os sujeitos explicam a variância do modelo

# Vamos primeiro extrair as variâncias atribuídas aos sujeitos, e a residual
var_ID_fleem_vigorosa <- VarCorr(modelo_FLEEM_vigorosa1)$ID
var_residual_fleem_vigorosa <- sigma(modelo_FLEEM_vigorosa1)^2

# Agora vamos calcular o ICC propriamente dito
ICC_modelo_vigorosa_fleem <- var_ID_fleem_vigorosa/(var_ID_fleem_vigorosa+var_residual_fleem_vigorosa)

# Vamos verificar um resumo do nosso modelo, com a função summary()
summary(modelo_FLEEM_vigorosa1)

# Esse pacote não exibe o efeito principal do nosso modelo, portanto, teremos que extrair isso usando a função anova()
anova(modelo_FLEEM_vigorosa1)

# As linhas acima não são suficientes para termos acesso à um teste posthoc, portanto, realizaremos isso de outra maneira
# Primeiro, vamos extrair as médias estimadas e realizar comparações
medias_emmeans_fleem_vigorosa <- emmeans(modelo_FLEEM_vigorosa1, ~ Semana)

# Agora, vamos comparar todas as médias entre si
comparacoes_fleem_vigorosa <- pairs(medias_emmeans_fleem_vigorosa)

# Agora vamos exibir as comparações
print(comparacoes_fleem_vigorosa)

# Vamos gerar um gráfico simples para visualizar nosso efeito fixo
sjPlot::plot_model(modelo_FLEEM_vigorosa1, type = "eff", terms = "Semana")


# Agora vamos carregar o banco de dados para fazer as análises dos modelos 5, 18 e 23, que foram baseados em dados do IPAQ com a remoção de possíveis outliers
dados2 <- read_excel("D:/Projeto_mestrado/Dissertacao/MastersDissertation/Dados/Sexto processamento/banco_dados_reestruturado_sem_outliers.xlsx")


# Podemos ver que a variável "semana" está definida como uma variável numérica. Portanto, vamos convertê-la em fator
dados2$Semana <- as.factor(dados2$Semana)


# Modelo 5 (Caminhada obtida através do IPAQ)

modelo_caminhada_ipaq <- lmer(Caminhada_IPAQ_10 ~ Semana + (1 | ID), data = dados2, na.action = na.exclude)
AIC_modelo_caminhada_ipaq <- AIC(modelo_caminhada_ipaq) # Extrai o AIC do modelo
BIC(modelo_caminhada_ipaq) # Extrai o BIC do modelo
qqnorm(residuals(modelo_caminhada_ipaq)); qqline(residuals(modelo_caminhada_ipaq)) #plota a distribuição dos resíduos


# Vamos calcular o ICC, para ver o quanto os sujeitos explicam a variância do modelo

# Vamos primeiro extrair as variâncias atribuídas aos sujeitos, e a residual
var_ID_ipaq_caminhada <- VarCorr(modelo_caminhada_ipaq)$ID
var_residual_ipaq_caminhada <- sigma(modelo_caminhada_ipaq)^2

# Agora vamos calcular o ICC propriamente dito
ICC_modelo_ipaq_caminhada <- var_ID_ipaq_caminhada/(var_ID_ipaq_caminhada+var_residual_ipaq_caminhada)

# Vamos verificar um resumo do nosso modelo, com a função summary()
summary(modelo_caminhada_ipaq)

# Esse pacote não exibe o efeito principal do nosso modelo, portanto, teremos que extrair isso usando a função anova()
anova(modelo_caminhada_ipaq)

# As linhas acima não são suficientes para termos acesso à um teste posthoc, portanto, realizaremos isso de outra maneira
# Primeiro, vamos extrair as médias estimadas e realizar comparações
medias_emmeans_ipaq_caminhada <- emmeans(modelo_caminhada_ipaq, ~ Semana)

# Agora, vamos comparar todas as médias entre si
comparacoes_ipaq_caminhada <- pairs(medias_emmeans_ipaq_caminhada)

# Agora vamos exibir as comparações
print(comparacoes_ipaq_caminhada)

# Vamos gerar um gráfico simples para visualizar nosso efeito fixo
sjPlot::plot_model(modelo_caminhada_ipaq, type = "eff", terms = "Semana")


# Modelo 18 (Atividade física moderada obtida através do IPAQ)

modelo_moderada_ipaq <- glmer(Moderada_IPAQ_10 ~ Semana + (1 | ID), data = dados2, family = Gamma(link="identity"), na.action = na.exclude)
AIC_modelo_moderada_ipaq <- AIC(modelo_moderada_ipaq)
BIC(modelo_moderada_ipaq)
qqnorm(residuals(modelo_moderada_ipaq)); qqline(residuals(modelo_moderada_ipaq))


# Vamos calcular o ICC, para ver o quanto os sujeitos explicam a variância do modelo

# Vamos primeiro extrair as variâncias atribuídas aos sujeitos, e a residual
var_ID_ipaq_moderada <- VarCorr(modelo_moderada_ipaq)$ID
var_residual_ipaq_moderada <- sigma(modelo_moderada_ipaq)^2

# Agora vamos calcular o ICC propriamente dito
ICC_modelo_ipaq_moderada <- var_ID_ipaq_moderada/(var_ID_ipaq_moderada+var_residual_ipaq_moderada)

# Vamos verificar um resumo do nosso modelo, com a função summary()
summary(modelo_moderada_ipaq)

# Esse pacote não exibe o efeito principal do nosso modelo, portanto, teremos que extrair isso usando a função anova()
anova(modelo_moderada_ipaq)

# As linhas acima não são suficientes para termos acesso à um teste posthoc, portanto, realizaremos isso de outra maneira
# Primeiro, vamos extrair as médias estimadas e realizar comparações
medias_emmeans_ipaq_moderada <- emmeans(modelo_moderada_ipaq, ~ Semana)

# Agora, vamos comparar todas as médias entre si
comparacoes_ipaq_moderada <- pairs(medias_emmeans_ipaq_moderada)

# Agora vamos exibir as comparações
print(comparacoes_ipaq_moderada)

# Vamos gerar um gráfico simples para visualizar nosso efeito fixo
sjPlot::plot_model(modelo_moderada_ipaq, type = "eff", terms = "Semana")


# Modelo 23 (atividade física vigorosa obtida através do IPAQ)

modelo_vigorosa_ipaq <- lmer(Vigorosa_IPAQ_10 ~ Semana + (1 | ID), data = dados2, na.action = na.exclude)
AIC_modelo_vigorosa_ipaq <- AIC(modelo_vigorosa_ipaq) #Extrai o AIC do modelo
BIC(modelo_vigorosa_ipaq)
qqnorm(residuals(modelo_vigorosa_ipaq)); qqline(residuals(modelo_vigorosa_ipaq)) #plota a distribuição dos resíduos


# Vamos calcular o ICC, para ver o quanto os sujeitos explicam a variância do modelo

# Vamos primeiro extrair as variâncias atribuídas aos sujeitos, e a residual
var_ID_ipaq_vigorosa <- VarCorr(modelo_vigorosa_ipaq)$ID
var_residual_ipaq_vigorosa <- sigma(modelo_vigorosa_ipaq)^2

# Agora vamos calcular o ICC propriamente dito
ICC_modelo_ipaq_vigorosa <- var_ID_ipaq_vigorosa/(var_ID_ipaq_vigorosa+var_residual_ipaq_vigorosa)

# Vamos verificar um resumo do nosso modelo, com a função summary()
summary(modelo_vigorosa_ipaq)

# Esse pacote não exibe o efeito principal do nosso modelo, portanto, teremos que extrair isso usando a função anova()
anova(modelo_vigorosa_ipaq)

# As linhas acima não são suficientes para termos acesso à um teste posthoc, portanto, realizaremos isso de outra maneira
# Primeiro, vamos extrair as médias estimadas e realizar comparações
medias_emmeans_ipaq_vigorosa <- emmeans(modelo_vigorosa_ipaq, ~ Semana)

# Agora, vamos comparar todas as médias entre si
comparacoes_ipaq_vigorosa <- pairs(medias_emmeans_ipaq_vigorosa)

# Agora vamos exibir as comparações
print(comparacoes_ipaq_vigorosa)

# Vamos gerar um gráfico simples para visualizar nosso efeito fixo
sjPlot::plot_model(modelo_vigorosa_ipaq, type = "eff", terms = "Semana")
