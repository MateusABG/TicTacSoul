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


func _on_Facil_pressed():
	Dificuldade.set_difficulty(Dificuldade.EASY)
	get_tree().change_scene("res://Scenes/Cutscene.tscn")
	pass # Replace with function body.


func _on_Medio_pressed():
	Dificuldade.set_difficulty(Dificuldade.MEDIUM)
	get_tree().change_scene("res://Scenes/Cutscene.tscn")
	pass # Replace with function body.


func _on_Dificil_pressed():
	Dificuldade.set_difficulty(Dificuldade.HARD)
	get_tree().change_scene("res://Scenes/Cutscene.tscn")
	pass # Replace with function body.


func _on_Facil_mouse_entered(): 
	pass # Replace with function body.
