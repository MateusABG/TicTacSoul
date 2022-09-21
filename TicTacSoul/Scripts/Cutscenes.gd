extends Node2D

#Imagens da cutscene
var image = preload("res://Sprites/HQ1.png")
var image2=preload("res://Sprites/HQ2.png")
var image3= preload("res://Sprites/HQ3.png")

#Inicia a cutscene com a primeira imagem
func _ready():
	$Images.texture=image;
	#Caso a cutscene esteja desligada, não a toque e mande o usuario para o jogo diretamente
	if(Dificuldade.get_cutscene_state()==Dificuldade.Cutscene.OFF):
		get_tree().change_scene("res://Scenes/GameScene.tscn") 

 
#Ao clicar na area da imagem, carrega a proxima até não houver mais, quando terminar, leva o usuario a tela do jogo
func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed :						# Botão foi pressionado
		# Troca de imagens
		if($Images.texture==image):
			$Images.texture=image2
		elif($Images.texture==image2):
			$Images.texture=image3
		else:
			#Desliga a cutscene, pois o jogador já a viu antes
			Dificuldade.set_cutscene_state(Dificuldade.Cutscene.OFF)
			get_tree().change_scene("res://Scenes/GameScene.tscn")

#Quando o botao skip for pressionado, leva o usuario a tela do jogo
func _on_Button_pressed():
	Dificuldade.set_cutscene_state(Dificuldade.Cutscene.OFF)
	get_tree().change_scene("res://Scenes/GameScene.tscn")
	pass # Replace with function body.
