extends Node

# Configuração: quantas linhas e colunas devo inicializar
export var linhas_tabuleiro = 3;
export var colunas_tabuleiro = 3;

#Jogador atual jogando (0=Ninguem, 1=Player1, 2=CPU/Jogador2)
export var jogador_atual=0;

var nodos_tabuleiro;	# Referência para cada posição do tabuleiro de jogo 
var game_ended;		# Verifica se jogo termina

#Definindo valores para os jogadores/IA
export var jogador=1
export var cpu=2

#Inicializando um tabuleiro auxiliar para as jogadas do minimax, este tabuleiro somente é usado pelo minimax
var nodos_locais=clear()

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
	nodos_tabuleiro = []
	for line in range(linhas_tabuleiro):
		nodos_tabuleiro.append([]);
		for column in range(colunas_tabuleiro):
			# Procurar node pelo nome
			var node = get_node("%d,%d" % [line, column]); 
			node.set_board(self, line, column);
			nodos_tabuleiro[line].append(node); 
	# Novo jogo
	reset_game();
	
# Reinicia o jogo
func reset_game():
	jogador_atual = 1;
	game_ended = false;
	for linha in range(linhas_tabuleiro):
		for coluna in range(colunas_tabuleiro):
			nodos_tabuleiro[linha][coluna].set_player(0);
			nodos_locais[linha][coluna]=0
	nodos_locais=clear()
	
# Chamado pelo BoardPiece quando a posição é clicada
func node_clicked(linha, coluna):	 
	# Ignora clique caso a casa já esteja ocupada 
	if(nodos_tabuleiro[linha][coluna].get_player() != 0):
		return;   
	make_move(linha, coluna, jogador_atual);    
# Executa uma jogada de um jogador na posição especificada
func make_move(line, column, player):  
	#Coloca player na posicao desejada
	 
	nodos_tabuleiro[line][column].set_player(player); 
	 
	#Coloca o valor do jogador dentro dos nodos locais
	if(player==jogador):  
		nodos_locais[line][column]=1
	else: 
		nodos_locais[line][column]=2  
		 
	# Verifica se o jogo terminou
	var winning_player = check_winner();
	if(winning_player == 3):
		game_ended = true; 
		return;
	if(winning_player > 0 and winning_player < 3):
		game_ended = true; 
		return;
	if(jogador_atual!=0): 
		$RockCollision.play()    
	#Jogada do player, caso o mesmo for cpu, somente se deve trocar o jogador
	if(jogador_atual == cpu):  
		
		jogador_atual = jogador
	else: 
		#Caso contrario, o mesmo deve checar a IA selecionada por dificuldade
		#Sendo elas
			# Fácil = Aleatória
			# Média = Parcialmente aleatória
			# Dificil = Minimax
		jogador_atual=cpu 
		
		#Variavel responsável por guardar as posições do proximo movimento
		var movimento
		
		#Se ainda houver espaços livres nos nodos locais/tabuleiro de nodos, continar jogando
		if(empty_cells(nodos_locais).size()!=0): 
			#Tocar o som de pensamento do player a fim de simular que a maquina está pensando 
			#Somente toca som de pensamento quando o modo for single player
			if(Dificuldade.get_difficulty() != Dificuldade.MULTIPLAYER):   
				yield(get_tree().create_timer(1),"timeout")
				$thinking.play()     
				yield(get_tree().create_timer(1),"timeout")
				$thinking.stop()     
			#Testa a dificuldade atual:
				#Se facil, usa o metodo aleatorio
				#Se dificil, usa o minimax
				#Se medio usa o método semi-minimax.
			if(Dificuldade.get_difficulty()==Dificuldade.EASY): 
				movimento=$AIMANAGER.easy_level() 
				node_clicked(movimento.x,movimento.y)
			elif(Dificuldade.get_difficulty()==Dificuldade.MEDIUM):  
				movimento=$AIMANAGER.medium_level()   
				node_clicked(movimento.x,movimento.y)
			elif(Dificuldade.get_difficulty()==Dificuldade.HARD):  
				movimento=$AIMANAGER.hard_level()  
				node_clicked(movimento.x,movimento.y)
		
	 
	

# Retorna se algum jogador ganhou o jogo atual.
func check_winner():
	# Checa vitória para cada player
	for player in [1, 2]:
		# Verifica linhas
		for line in range(linhas_tabuleiro):
			if(check_line(line, player)):
				return player;
		
		# Verifica colunas
		for column in range(colunas_tabuleiro):
			if(check_column(column, player)):
				return player;
				
		# Verifica diagonais
		for diagonal in [0, 2]:
			if(check_diagonal(diagonal, player)):
				return player;
				
	#Verifica se todas as posicoes estão ocupadas 
	var empty_positions = 0;
	for line in range(linhas_tabuleiro):
		for column in range(colunas_tabuleiro):
			if(nodos_tabuleiro[line][column].get_player() == 0):
				empty_positions += 1;
				
	# Se todas as posições estão ocupadas, deu velha, retorna valor correspondente
	if(empty_positions == 0):
		return 3;
		
	# Se não, o jogo ainda não terminou.
	return 0;
	
	
# Verifica se há uma linha inteira preenchida por um unico player
func check_line(line, player):
	for column in range(colunas_tabuleiro):
		if(nodos_tabuleiro[line][column].get_player() != player):
			return false;
	return true;
	
# Verifica se há uma coluna inteira preenchida por um unico player
func check_column(column, player):
	for line in range(linhas_tabuleiro):
		if(nodos_tabuleiro[line][column].get_player() != player):
			return false;
	return true;

# Verifica se uma diagonal inteira está marcada como um certo player	 
func check_diagonal(diagonal, player):
	# Percorre as linhas
	for line in range(linhas_tabuleiro):
		var column;
		# se for diagonal principal, a coluna deve ser igual a linha (Formato \)
		if(diagonal == 0): 
			column = line;
		else: 
			#caso contrario, a coluna deve ser o contrário da linha (Formato /)
			column = colunas_tabuleiro - line - 1;
		
		#Se não houver player nessas diagonais, retorna falso
		if(nodos_tabuleiro[line][column].get_player() != player):
			return false;
			
	return true; 
#Retorna um array de posicoes vazias no tabuleiro
func empty_cells(tab):
	var celulas=[]
	for i in range(len(tab)):
		for j in range(len(tab[i])):
			if(tab[i][j]==0):
				celulas.append([i,j])
	return celulas
  
	 
func _process(delta):
	#Verifica se o jogo terminou
	if(game_ended): 
		# Se sim, verifica o vencedor
		if(check_winner()==1):
			#Muda o jogador atual para 0 a fim do mesmo não poder mais selecionar nada
			# Assim como a IA
			jogador_atual=0
			#Toca a animacao de desenho da linha
			$SceneManager.play_animation(jogador)
			#Adiciona-se um timer de um segundo
			yield(get_tree().create_timer(1),"timeout") 
			#Carrega a tela de vitoria
			if(Dificuldade.MULTIPLAYER==Dificuldade.get_difficulty()):
				get_tree().change_scene("res://Scenes/Player1Wins.tscn")
			else:
				get_tree().change_scene("res://Scenes/SinglePlayerWins.tscn")
		elif(check_winner()==2):
			#Muda o jogador atual para 0 a fim do mesmo não poder mais selecionar nada
			# Assim como a IA
			jogador_atual=0
			#Toca a animacao de desenho da linha 			
			$SceneManager.play_animation(cpu)
			#Adiciona-se um timer de um segundo
			yield(get_tree().create_timer(1),"timeout")
			#Carrega a tela de vitoria
			#Carrega a tela de vitoria
			if(Dificuldade.MULTIPLAYER==Dificuldade.get_difficulty()):
				get_tree().change_scene("res://Scenes/Player2Wins.tscn")
			else:
				get_tree().change_scene("res://Scenes/Lose.tscn")
		else:
			#Muda o jogador atual para 0 a fim do mesmo não poder mais selecionar nada
			# Assim como a IA
			jogador_atual=0
			yield(get_tree().create_timer(1),"timeout")
			#Carrega a tela de empate
			get_tree().change_scene("res://Scenes/Tie.tscn")
		return;



