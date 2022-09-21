extends Area2D

# Lista de texturas para cada player
# Incluindo a posição [0] para representar um espaço vazio
export(Array, Texture) var texturas;

var marcacao_jogador: int; # Marcação atual nessa posição (0, 1, 2)
var sprite;		# Referência para o sprite dessa posição
var board;		# Referência para o board
var pos_linha;	# Minha posição no board (linha)
var pos_coluna;	# Minha posição no board (coluna)

# Inicialização
func _ready():
	sprite = get_node("Sprite");
	set_player(0);
	
# 
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed: 
			# Chama a função no board para avisar que a posição foi clicada   
			if(Dificuldade.MULTIPLAYER != Dificuldade.get_difficulty()):
				if(board.jogador_atual==board.jogador):  
					board.node_clicked(pos_linha, pos_coluna)  
			else:  
				board.node_clicked(pos_linha, pos_coluna)  
		
#Retorna o jogador alocado nesta posicao
func get_player():
	return marcacao_jogador;

# Define um jogador para a posicao atual
func set_player(player):
	marcacao_jogador = player;
	sprite.texture = texturas[player];

# Inicia o tabuleiro 
func set_board(tabuleiro, linha, coluna):
	self.board = tabuleiro;
	pos_linha = linha;
	pos_coluna = coluna;
