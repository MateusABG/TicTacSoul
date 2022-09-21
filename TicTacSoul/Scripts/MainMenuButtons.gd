extends Node2D
 
#Verifica se o botão start foi pressionado, se sim, leva o usuário a tela de seleção de dificuldade
func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/DifficultyChoice.tscn")
	pass # Replace with function body.
 
#Verifica se o botão multiplayer foi pressionado, se sim, leva o usuário a tela de seleção de jogo
func _on_Multiplayer_pressed():
	Dificuldade.set_difficulty(Dificuldade.MULTIPLAYER)
	get_tree().change_scene("res://Scenes/GameScene.tscn")
	pass # Replace with function body.


#Verifica se o botão quit foi pressionado, se sim, fecha o jogo 
func _on_End_pressed():
	get_tree().quit()
	pass # Replace with function body.

#Quando passar por cima do botao 
func _on_Start_mouse_entered(): 
	$ButtonSlide.play()
	pass # Replace with function body. 

func _on_Multiplayer_mouse_entered():
	$ButtonSlide.play()
	pass # Replace with function body.


func _on_End_mouse_entered():
	$ButtonSlide.play()
	pass # Replace with function body.
