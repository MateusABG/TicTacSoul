extends Area2D

# Lista de texturas para cada player
# Incluindo a posição [0] para representar um espaço vazio
export(Array, Texture) var player_textures;

var player_marked: int; # Marcação atual nessa posição (0, 1, 2)
var sprite;		# Referência para o sprite dessa posição
var board;		# Referência para o board
var pos_line;	# Minha posição no board (linha)
var pos_column;	# Minha posição no board (coluna)

# Inicialização
func _ready():
	sprite = get_node("Sprite");
	set_player(0);
	
# Chamado pela Godot quando o Area2D recebe um evento
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed: 
			# Chama a função no board para avisar que a posição foi clicada   
			if(Dificuldade.MULTIPLAYER != Dificuldade.get_difficulty()):
				if(board.current_player==board.jogador): 
					board.node_clicked(pos_line, pos_column)  
			else: 
				board.node_clicked(pos_line, pos_column)  
		
# Retorna para o board o player marcado nesta posição
func get_player():
	return player_marked;

# Permite o board definir o player marcado nesta posição
func set_player(player):
	player_marked = player;
	sprite.texture = player_textures[player];

# Inicializa esta posição com uma referência para o board, e minha posição nele
func set_board(board, line, column):
	self.board = board;
	pos_line = line;
	pos_column = column;
