extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var image = preload("res://Sprites/HQ1.png")
var image2=preload("res://Sprites/HQ2.png")
var image3= preload("res://Sprites/HQ3.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Images.texture=image;
	if(Dificuldade.get_cutscene_state()==Dificuldade.Cutscene.OFF):
		get_tree().change_scene("res://Scenes/GameScene.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed :						# Botão foi pressionado
		# Chama a função no board para avisar que a posição foi clicada
		if($Images.texture==image):
			$Images.texture=image2
		elif($Images.texture==image2):
			$Images.texture=image3
		else:
			Dificuldade.set_cutscene_state(Dificuldade.Cutscene.OFF)
			get_tree().change_scene("res://Scenes/GameScene.tscn")


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/GameScene.tscn")
	pass # Replace with function body.
