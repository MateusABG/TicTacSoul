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


func _on_TryAgain_pressed():
	get_tree().change_scene("res://Scenes/GameScene.tscn")
	pass # Replace with function body.


func _on_QUIT_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_VoltarAoMenu_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
	pass # Replace with function body.
