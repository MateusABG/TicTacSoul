extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/Dificuldade_choice.tscn")
	pass # Replace with function body.


func _on_Multiplayer_pressed():
	Dificuldade.set_difficulty(Dificuldade.MULTIPLAYER)
	get_tree().change_scene("res://Scenes/GameScene.tscn")
	pass # Replace with function body.


func _on_End_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_Start_mouse_entered(): 
	pass # Replace with function body.
