extends Node2D


 
 

#Quando o botão selecionado for o da dificuldade fácil, coloca como dificuldade selecionada a facil 
#Levando o jogador a cena de cutscene
func _on_Facil_pressed():
	Dificuldade.set_difficulty(Dificuldade.EASY)
	get_tree().change_scene("res://Scenes/Cutscene.tscn")
	pass # Replace with function body.


#Quando o botão selecionado for o da dificuldade médio, coloca como dificuldade selecionada a medio
#Levando o jogador a cena de cutscene
func _on_Medio_pressed():
	Dificuldade.set_difficulty(Dificuldade.MEDIUM)
	get_tree().change_scene("res://Scenes/Cutscene.tscn")
	pass # Replace with function body.


#Quando o botão selecionado for o da dificuldade dificil, coloca como dificuldade selecionada a dificil 
#Levando o jogador a cena de cutscene
func _on_Dificil_pressed():
	Dificuldade.set_difficulty(Dificuldade.HARD)
	get_tree().change_scene("res://Scenes/Cutscene.tscn")
	pass # Replace with function body.

#AO passar por cima dos botoes, tocar o som desejado
func _on_Facil_mouse_entered(): 
	$SlideSFX.play()
	pass # Replace with function body.


func _on_Medio_mouse_entered():
	$SlideSFX.play()
	pass # Replace with function body.


func _on_Dificil_mouse_entered():
	$SlideSFX.play()
	pass # Replace with function body.
