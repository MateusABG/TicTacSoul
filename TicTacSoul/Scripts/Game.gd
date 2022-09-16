extends Node

# Configuração: quantas linhas e colunas devo inicializar
export var lines_board = 3;
export var column_board = 3;
export var current_player=0;

var board_nodes;	# Referência para cada posição do tabuleiro de jogo 
var game_ended;		# Verifica se jogo termina

#Definindo valores para os jogadores/IA
export var jogador=1
export var cpu=2

#Inicializando um tabuleiro auxiliar para as jogadas do minimax
var local_nodes=clear()

#Limpa tabuleiro local
func clear():
	return [
					[0,0,0],
					[0,0,0],
					[0,0,0]
				]
# Inicialização
func _ready():
	# Criar matriz de posições apontando para cada node
	board_nodes = []
	for line in range(lines_board):
		board_nodes.append([]);
		for column in range(column_board):
			# Procurar node pelo nome
			var node = get_node("%d,%d" % [line, column]); 
			node.set_board(self, line, column);
			board_nodes[line].append(node);
	print(board_nodes)
	# Novo jogo
	reset_game();
	
# Reinicia o jogo
func reset_game():
	current_player = 1;
	game_ended = false;
	for line in range(lines_board):
		for column in range(column_board):
			board_nodes[line][column].set_player(0);
			local_nodes[line][column]=0
	local_nodes=clear()
	
# Chamado pelo BoardPiece quando a posição é clicada
func node_clicked(line, column):	 
	# Ignora clique caso a casa já esteja ocupada
	$RockCollision.play(0.0)
	if(board_nodes[line][column].get_player() != 0):
		return;   
	make_move(line, column, current_player);

 
# Executa uma jogada de um jogador na posição especificada
func make_move(line, column, player):  
	#Coloca player na posicao desejada
	board_nodes[line][column].set_player(player); 
	#Coloca o valor do jogador dentro dos nodos locais
	if(player==jogador): 
		local_nodes[line][column]=1
	else: 
		local_nodes[line][column]=2 
		 
	# Verifica se o jogo terminou
	var winning_player = check_winner();
	if(winning_player == 3):
		game_ended = true; 
		return;
	if(winning_player > 0 and winning_player < 3):
		game_ended = true; 
		return;
	 
	#Jogada do player, caso o mesmo for cpu, somente se deve trocar o jogador
	if(current_player == cpu):  
		current_player = jogador
	else: 
		#Caso contrario, o mesmo deve checar a IA selecionada por dificuldade
		#Sendo elas
			# Fácil = Aleatória
			# Média = Parcialmente aleatória
			# Dificil = Minimax
		current_player=cpu 
		var move
		if(celulas_vazias(local_nodes).size()!=0):
			if(Dificuldade.get_difficulty()==Dificuldade.EASY): 
				move=$AIMANAGER.random_move() 
				node_clicked(move.x,move.y)
			elif(Dificuldade.get_difficulty()==Dificuldade.MEDIUM): 
				move=$AIMANAGER.nivel_medio()   
				node_clicked(move.x,move.y)
			elif(Dificuldade.get_difficulty()==Dificuldade.HARD): 
				move=minimax()  
				node_clicked(move.x,move.y)
		
	

# Retorna se algum jogador ganhou o jogo atual.
func check_winner():
	# Checa vitória para cada player
	for player in [1, 2]:
		# Verifica linhas
		for line in range(lines_board):
			if(check_line(line, player)):
				return player;
		
		# Verifica colunas
		for column in range(column_board):
			if(check_column(column, player)):
				return player;
				
		# Verifica diagonais
		for diagonal in [0, 2]:
			if(check_diagonal(diagonal, player)):
				return player;
				
	#Verifica se todas as posicoes estão ocupadas 
	var empty_positions = 0;
	for line in range(lines_board):
		for column in range(column_board):
			if(board_nodes[line][column].get_player() == 0):
				empty_positions += 1;
				
	# Se todas as posições estão ocupadas, deu velha, retorna valor correspondente
	if(empty_positions == 0):
		return 3;
		
	# Se não, o jogo ainda não terminou.
	return 0;
	
	
# Verifica se há uma linha inteira preenchida por um unico player
func check_line(line, player):
	for column in range(column_board):
		if(board_nodes[line][column].get_player() != player):
			return false;
	return true;
	
# Verifica se há uma coluna inteira preenchida por um unico player
func check_column(column, player):
	for line in range(lines_board):
		if(board_nodes[line][column].get_player() != player):
			return false;
	return true;

# Verifica se uma diagonal inteira está marcada como um certo player	 
func check_diagonal(diagonal, player):
	# Percorre as linhas
	for line in range(lines_board):
		var column;
		# se for diagonal principal, a coluna deve ser igual a linha (Formato \)
		if(diagonal == 0): 
			column = line;
		else: 
			#caso contrario, a coluna deve ser o contrário da linha (Formato /)
			column = column_board - line - 1;
		
		#Se não houver player nessas diagonais, retorna falso
		if(board_nodes[line][column].get_player() != player):
			return false;
			
	return true;
	
  
func ganha(tabuleiro,jogador):
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
	if (ganha(tabuleiro,2)):
		return 1
	elif (ganha(tabuleiro,1)):
		return -1
	elif(empate(tabuleiro)):
		return 0
	else:
		return "continua"

#Verifica se houve empate no jogo (velha), passando por todas as posicoes do tabuleiro passado
#e vendo se o mesmo está com o valor 0
func empate(tabuleiro):
	var emp = true
	for i in range(tabuleiro.size()):
		for j in range(tabuleiro[i].size()):
			if (tabuleiro[i][j]==0):
				emp=false
	return emp

#Função minimax como vista em aula
func minimax():
	var melhorJogada
	var melhorJogadaValue=-1
	
	#Passa por todas as casas do tabuleiro auxiliar
	for i in range(local_nodes.size()):
		for j in range(local_nodes[i].size()):
			#Caso o mesmo for zero, realiza-se a acao da jogada
			if (local_nodes[i][j]==0):
				##Duplica o estado atual do tabuleiro auxiliar
				var copy = local_nodes.duplicate(true)
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
	
 
 

#Nível médio é uma mistura de ambos os métodos usados, tanto o aletório quanto o minimax
#inicia-se uma variavel rng com um gerador de valores aleatorios

var rng= RandomNumberGenerator.new()  
func nivel_medio():  
	#Realiza o comando randomize para vir numeros completamente aleatorios
	rng.randomize()
	#Gera um numero entre 0 e 10
	var rand=rng.randi_range(0,10) 
	#Variavel que guarda o movimento da IA
	var move
	
	#Caso o valor aleatorio for menor ou igual a 3 (30%)
	#Realiza-se a selecao aleatoria da posicao
	if(rand<=3): 
		var x=rng.randi_range(0,2)
		var y=rng.randi_range(0,2)
		while(board_nodes[x][y].get_player()!=0):
			x=rng.randi_range(0,2)
			y=rng.randi_range(0,2)
		return  {"x":x,"y":y}
	else:  
		#Caso contrário, aplica-se minimax
		var melhorJogadaValue=-1
	
		for i in range(local_nodes.size()):
			for j in range(local_nodes[i].size()):
				if (local_nodes[i][j]==0): 
					var copy = local_nodes.duplicate(true)
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

#Funcao completamente aleatoria
func random_move():  
	#Realiza o comando randomize para vir numeros completamente aleatorios
	rng.randomize()
	#Escolhe dois valores aleatorios entre 0 e valor maximo do tabuleiro
	var x=rng.randi_range(0,lines_board)
	var y=rng.randi_range(0,column_board)
	#Se ele já estiver ocupado, procura seleciona outros valores aleatórios até o mesmo estar vazio
	while(board_nodes[x][y].get_player()!=0):
		x=rng.randi_range(0,2)
		y=rng.randi_range(0,2)
	return {"x":x,"y":y}
	 
func _process(delta):
	#Verifica se o jogo terminou
	if(game_ended): 
		# Se sim, verifica o vencedor
		if(check_winner()==1):
			#Muda o jogador atual para 0 a fim do mesmo não poder mais selecionar nada
			# Assim como a IA
			current_player=0
			#Toca a animacao de desenho da linha
			$SceneManager.play_animation(jogador)
			#Adiciona-se um timer de um segundo
			yield(get_tree().create_timer(1),"timeout") 
			#Carrega a tela de vitoria
			get_tree().change_scene("res://Scenes/WIN.tscn")
		elif(check_winner()==2):
			#Muda o jogador atual para 0 a fim do mesmo não poder mais selecionar nada
			# Assim como a IA
			current_player=0
			#Toca a animacao de desenho da linha 			
			$SceneManager.play_animation(cpu)
			#Adiciona-se um timer de um segundo
			yield(get_tree().create_timer(1),"timeout")
			#Carrega a tela de vitoria
			get_tree().change_scene("res://Scenes/Lose.tscn")
		else:
			#Muda o jogador atual para 0 a fim do mesmo não poder mais selecionar nada
			# Assim como a IA
			current_player=0
			yield(get_tree().create_timer(1),"timeout")
			#Carrega a tela de empate
			get_tree().change_scene("res://Scenes/Tie.tscn")
		return;
