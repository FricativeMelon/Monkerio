extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func change_monkey(m : Node2D):
	m.try_sell()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func monkey_leaves(m):
	pass	
