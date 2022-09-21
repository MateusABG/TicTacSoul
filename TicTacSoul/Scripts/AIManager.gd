extends Node



#Variaveis declaradas com os valores dos jogador a serem usados no script (1 para jogador,2 para cpu)
export var jogador=1
export var cpu=2 

#Mesmos dados encontrados no script Game.gd
#Servem para demarcar o tamanho do tabuleiro e o jogador atual que está a jogar
export var linhas_tabuleiro = 3;
export var colunas_tabuleiro = 3;
export var jogador_atual=0;

 #Gerador aleatório de número
# Usado no metodo completamente aleatorio(EASY) e metodo semi-aleatorio(MEDIUM)
var rng= RandomNumberGenerator.new()  
#Funcao completamente aleatoria
func easy_level():  
	#Realiza o comando randomize para vir numeros completamente aleatorios
	rng.randomize()
	#Escolhe dois valores aleatorios entre 0 e valor maximo do tabuleiro
	var x=rng.randi_range(0,linhas_tabuleiro-1)
	var y=rng.randi_range(0,colunas_tabuleiro-1)
	#Se ele já estiver ocupado, procura seleciona outros valores aleatórios até o mesmo estar vazio
	while(get_node("%Tabuleiro").nodos_locais[x][y]!=0):
		x=rng.randi_range(0,2)
		y=rng.randi_range(0,2)
	return {"x":x,"y":y}
	 
#-----------------------------------------------------------------------------------------------------------------------------------

#Nível médio é uma mistura de ambos os métodos usados, tanto o aletório quanto o minimax
#inicia-se uma variavel rng com um gerador de valores aleatorios 
func medium_level():  
	#Realiza o comando randomize para vir numeros completamente aleatorios
	rng.randomize()
	#Gera um numero entre 0 e 10
	var rand=rng.randi_range(0,10) 
	#Variavel que guarda o movimento da IA
	var move
	
	#Caso o valor aleatorio for menor ou igual a 3 (30%)
	#Realiza-se a selecao aleatoria da posicao
	if(rand<=3): 
		var x=rng.randi_range(0,linhas_tabuleiro-1)
		var y=rng.randi_range(0,colunas_tabuleiro-1)
		while(get_node("%Tabuleiro").nodos_tabuleiro[x][y].get_player()!=0):
			x=rng.randi_range(0,2)
			y=rng.randi_range(0,2)
		return  {"x":x,"y":y}
	else:  
		#Caso contrário, aplica-se minimax
		var melhorJogadaValue=-1
	
		for i in range(get_node("%Tabuleiro").nodos_locais.size()):
			for j in range(get_node("%Tabuleiro").nodos_locais[i].size()):
				if (get_node("%Tabuleiro").nodos_locais[i][j]==0): 
					var copy = get_node("%Tabuleiro").nodos_locais.duplicate(true)
					copy[i][j]=2
					var result = game_over(copy) 
					if (String(result) =="1"):
						return {"x":i,"y":j}
					elif (String(result) =="0"):
						return {"x":i,"y":j} 
					elif (result=="continua"):
						var v =minimaxAux(copy,false)
						if (v>=melhorJogadaValue):
							melhorJogadaValue=v
							move= {"x":i,"y":j}	
	return move 
#-----------------------------------------------------------------------------------------------------------------------------------


func winner(tabuleiro,jogador):
	#Todos os possiveis estados de vitoria para os players
	var win_estado=[
		[tabuleiro[0][0],tabuleiro[0][1],tabuleiro[0][2]],
		[tabuleiro[1][0],tabuleiro[1][1],tabuleiro[1][2]],
		[tabuleiro[2][0],tabuleiro[2][1],tabuleiro[2][2]],
		[tabuleiro[0][0],tabuleiro[1][0],tabuleiro[2][0]],
		[tabuleiro[0][1],tabuleiro[1][1],tabuleiro[2][1]],
		[tabuleiro[0][2],tabuleiro[1][2],tabuleiro[2][2]],
		[tabuleiro[0][0],tabuleiro[1][1],tabuleiro[2][2]],
		[tabuleiro[0][2],tabuleiro[1][1],tabuleiro[2][0]]
	] 
	#Verifica se o array de jogador está em algum estado de vitoria
	#Se sim, retorna verdadeiro, pois o mesmo ganhou
	#Caso contrario, falso
	if([jogador,jogador,jogador]in win_estado):
		return true
	return false


#Retorna um array de posicoes vazias no tabuleiro
func celulas_vazias(tab):
	var celulas=[]
	for i in range(len(tab)):
		for j in range(len(tab[i])):
			if(tab[i][j]==0):
				celulas.append([i,j])
	return celulas
 
#Verifica se o jogo terminou, retornando quem ganhou em caso de vitoria,0 em caso de empate e uma string
# Continua em caso de o jogo não ter terminado
func game_over(tabuleiro):
	if (winner(tabuleiro,2)):
		return 1
	elif (winner(tabuleiro,1)):
		return -1
	elif(tie(tabuleiro)):
		return 0
	else:
		return "continua"

#Verifica se houve empate no jogo (velha), passando por todas as posicoes do tabuleiro passado
#e vendo se o mesmo está com o valor 0
func tie(tabuleiro):
	var emp = true
	for i in range(tabuleiro.size()):
		for j in range(tabuleiro[i].size()):
			if (tabuleiro[i][j]==0):
				emp=false
	return emp

#Função minimax como vista em aula
func hard_level():
	var melhorJogada
	var melhorJogadaValue=-1
	
	#Passa por todas as casas do tabuleiro auxiliar
	for i in range(get_node("%Tabuleiro").nodos_locais.size()):
		for j in range(get_node("%Tabuleiro").nodos_locais[i].size()):
			#Caso o mesmo for zero, realiza-se a acao da jogada
			if (get_node("%Tabuleiro").nodos_locais[i][j]==0):
				##Duplica o estado atual do tabuleiro auxiliar
				var copy = get_node("%Tabuleiro").nodos_locais.duplicate(true)
				#Adiciona a CPU em uma posicao vazia
				copy[i][j]=cpu
				#Verifica caso de vitoria
				var result = game_over(copy)
				
				#Se ganhou, retorna a posicao da jogada, o mesmo para um empate
				if (String(result) =="1"):
					return {"x":i,"y":j}
				elif (String(result) =="0"):
					return {"x":i,"y":j}
				elif (result=="continua"):
					#Em caso de continuacao, chama-se o metodo auxiliar o qual valoriza as jogadas
					# do minimax
					var v =minimaxAux(copy,false)
					#Troca-se a melhor jogada caso a atual seja maior que a melhor jogada anterior 
					if (v>melhorJogadaValue):
						melhorJogadaValue=v
						melhorJogada= {"x":i,"y":j}
	return melhorJogada


func minimaxAux(tabuleiro,isMax):
	#Valor da melhor jogada possivel
	var melhorJogadaValue
	#Verifica se a jogada é para max ou para min, colocando um valor arbitrário para os casos
	# -1 para max
	# 1 para min
	if (isMax):
		melhorJogadaValue=-1
	else:
		melhorJogadaValue=1
	
	#Mesmos passos feitos no minimax principal
	for i in range(tabuleiro.size()):
		for j in range(tabuleiro[i].size()):
			if (tabuleiro[i][j]==0):
				var copy = tabuleiro.duplicate(true)
				#Se for max, adiciona a CPU na posição escolhida, caso contrario, adiciona o player
				if (isMax):
					copy[i][j]=2
				else:
					copy[i][j]=1
					
				#Verifica caso de vitoria
				var result  = game_over(copy)
				#Se continua, troca para o valor de ismax e reinicia o processo				
				if (String(result)=="continua"):
					result = minimaxAux(copy,!isMax)			
				
				#Se a jogada atual for max, realiza a troca do valor da melhor jogada caso a mesma for
				# MENOR que o resultado atual		
				if(isMax):
					if (result==1):
						return result
					elif (result>=melhorJogadaValue):
							melhorJogadaValue= result
				else:
					#Se a jogada atual for min, realiza a troca do valor da melhor jogada caso a mesma for
					# MAIOR que o resultado atual
					if (result==-1):
						return result
					elif (result<=melhorJogadaValue):
							melhorJogadaValue= result
		
	return melhorJogadaValue
 
