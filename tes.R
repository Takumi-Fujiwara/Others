
'title: "Algortimo para automatizar a análise de frequência"
Input:  Tabela de dados
output: Imagens png
Obs:  Separa em grupos definidos na tabela 
      média ou frequência definir manualmente 
      cores dos graficos manualmente
'


#PACOTES UTILIZADOS

library(dplyr)            # Manipulação de dados
library(openxlsx)         # Trabalhar com arquivos que possuem externos .xlsx
library(RColorBrewer)     # Cores 
library(utf8)             # textos

#ENTRADA DADOS 
dados <- read.csv(file="teste3.csv", sep=",", na.strings=T)

n = 6                     #Numero de grupos

for (j in 1:n){
  dados_aux = subset(dados,dados[,2]==j)
  nome = names(dados)
  nome_grupo = paste("grupo ",as.character(j), sep ="")
  
  #Frequência relativa de cada coluna
  for (i in 1:length(dados[1,])){
    if(i ==4|i==39|i==40){
      date = dados_aux[,i]
      plot(1:length(date), date,main = nome_grupo, xlab= paste("Média = ",as.character(mean(date))), ylab= as.character(nome[i]),type ="l" , cex.axis = 0.75)
      lines(1:length(date),rep(mean(date),length(date)) , type ="l", col ="red", lwd = 4)
      
      nome_arquivo = paste(j, "_",as.character(nome[i]),".png",sep = "")
      dev.copy(device = png, as.character(nome_arquivo))
      dev.off()
    }
    else{
      date = table(dados_aux[,i])
      test = prop.table(date)*100
      k =3
      if(i==5){k=8}
      if(i==7){k=6}
      if(i==36|i==37){k=5}
      if(i==38){k=4}
      barplot(test,ylab ="Freq %",main = nome_grupo, xlab= as.character(nome[i]), ylim = c(0,90), space = 1, col = brewer.pal(n=k, name = "RdBu"), legend.text = TRUE )
      nome_arquivo = paste(j, "_",as.character(nome[i]),".png",sep = "")
      dev.copy(device = png, as.character(nome_arquivo))
      dev.off()
      
  }}}