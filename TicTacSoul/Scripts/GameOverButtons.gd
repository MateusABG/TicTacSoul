extends Node2D

 

#Ao clicar no botão de tentar de novo, voltar a cena do jogo
func _on_TryAgain_pressed():
	get_tree().change_scene("res://Scenes/GameScene.tscn")
	pass # Replace with function body.

#Se clicar em sair, sai do jogo
func _on_QUIT_pressed():
	get_tree().quit()
	pass # Replace with function body.

#Ao clicar neste botão, voltar ao menu
func _on_VoltarAoMenu_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
	pass # Replace with function body.


func _on_TryAgain_mouse_entered(): 
	$SlideSFX.play()
	pass # Replace with function body.


func _on_VoltarAoMenu_mouse_entered(): 
	$SlideSFX.play()
	pass # Replace with function body.


func _on_QUIT_mouse_entered():
	$SlideSFX.play()
	pass # Replace with function body.
