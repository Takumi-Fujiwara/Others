import numpy as np
from sklearn.linear_model import LinearRegression
import matplotlib.pyplot as plt

# velocidades de corte
vcs = [200, 224, 250 ]         

# Desgastes no tempo por Vc
vb_200 = np.array([0.07, 0.08, 0.10, 0.16, 0.18, 0.22, 0.27, 0.31, 0.38 ])
vb_224 = np.array([0.06, 0.11, 0.16, 0.20, 0.22, 0.25, 0.30, 0.38])
vb_250 = np.array([0.1, 0.15, 0.2, 0.28, 0.31, 0.4, 0.48])

# Tempos 
tempo = np.array([2, 4, 8, 12.5, 16, 20, 25, 31.5, 40])

#Critério de vida - Vb
vb = 0.35

#Auxiliares
coeficientes ={}
coeficientes_2 = {}
log_time = []
x=[]
t = []

#Variaveis para teste
vc_teste = np.arange(100,500,20)
#vida_teste = range(1,80,1)       # Permite alternar a utilização da Vc pelo Tempo de vida



#Primeira regressão *** n vezes, sendo n o numero de vcs disponivel
for n in range(len(vcs)):
    name = 'vb_' + str(vcs[n])
    time = np.array(tempo[:len(globals()[name])])
    model = LinearRegression().fit(time.reshape(-1, 1), globals()[name])
    coeficientes[name] = {'A' : model.coef_[0], 'B' : model.intercept_}

#Logaritmos - Vcs | Tempo para desgaste
for n in range(len(vcs)):
    name = 'vb_' + str(vcs[n])
    x.append(np.log10((vb - coeficientes[name]['B'])/coeficientes[name]['A']))
    log_time.append(np.log10(vcs[n]))

#Segunda regressão
model = LinearRegression().fit(np.array(log_time).reshape(-1, 1), np.array(x))
coeficientes_2['Taylor'] = {'A' : model.coef_[0], 'B' : model.intercept_}

#Coeficientes Taylor
expoente = coeficientes_2['Taylor']['A'] 
k = 10**coeficientes_2['Taylor']['B'] 

#printa a equação 
print( f'T ={k:.2e} * Vc ^ {expoente:.3f} ' )

#Calulo de ponto na equação - T = 25
c = (25/k)**(1/expoente)


#Strings para o titulo
x_titulo = str(round(expoente, 3))
k_titulo = str(np.format_float_scientific(k, precision = 2, exp_digits=1))


# Gerar vetor tempo de vida usando Vcs
for n in vc_teste:
    t.append(k*n**expoente) 
 
"""
#Gerar vetor de Vcs usando tempo de vida
for n in vida_teste:
    t.append((n/k)**(1/expoente)) 
"""

#Plotagem
plt.title('T = ' + k_titulo + r'$ Vc^{%s}$'%x_titulo , fontsize =10)        #Titulo 
plt.xlabel("Velocidade de corte (m/min)")                                   #Nome eixo X
plt.ylabel("Vida de ferramenta (min)")                                      #Nome eixo y
plt.text(300, 25, 'T = 25  ' + '|| Vc = %2f'%c, fontsize=10)                #Descrição ponto
plt.plot(vc_teste, t)                                                       #Plot equação Vc x T
plt.plot(c, 25, 'o' )                                                       #Ponto
plt.xlim(50, 600)                                                           #Limite grafico X
plt.ylim(0, 150)                                                            #Limite grafico Y
plt.show()                                                                  #Plota o gráfico