extends Node


# Declara os níveis de dificuldade como numeradores
enum {EASY,MEDIUM,HARD,MULTIPLAYER}


#Enumerador para ativar ou desativar a cena de abertura do jogo
enum Cutscene{ON,OFF}

#Variavel que irá guardar permanentemente a dificuldade do jogo, até que a mesma seja alterada
export var difficulty:int

#Variavel que irá guardar permanentemente o estado da cutscene, ou seja, se está ativa ou não
export var cutscene_turn:int

func _ready():
	pass # Replace with function body.

#Declara um novo objecto dificuldade
func new():
	difficulty=-1

#Coloca o valor de dificuldade de acordo com o passado
func set_difficulty(dif):
	difficulty=dif

#Retorna a dificuldade atual escolhida
func get_difficulty():
	return difficulty

#Diz se dá ou não play na cutscene
func set_cutscene_state(state):
	cutscene_turn=state

#Retorna se dá ou não play na cutscene
func get_cutscene_state():
	return cutscene_turn
