extends Sprite

#Carrega, ao executar este codigo, as logos de emate para multiplayer e single player
onready var empateM=preload("res://Sprites/StartScreen/MultiplayerEmpate.png")
onready var empateS=preload("res://Sprites/StartScreen/VoceEmpatou.png")


func _ready():
	#Se estiver jogando em multiplayer, a tela de empate mostra a textura de empate para multijogador
	if(Dificuldade.get_difficulty()==Dificuldade.MULTIPLAYER):
		texture=empateM
	else:
		#Se estiver jogando em single player, a tela de empate mostra a textura de empate para single player
		texture=empateS 


 
