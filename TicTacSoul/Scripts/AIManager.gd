extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text" 
export var jogador=1
export var cpu=2 


var HUMAN=-1
var COMP=1
onready var local_nodes= get_node("%Board").local_nodes
 
var rng= RandomNumberGenerator.new()  
func random_move():  
	rng.randomize()
	var x=rng.randi_range(0,2)
	var y=rng.randi_range(0,2)
	while(local_nodes[x][y]!=0):
		x=rng.randi_range(0,2)
		y=rng.randi_range(0,2)
	return {"x":x,"y":y}
  
