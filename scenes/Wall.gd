extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _init():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("..").walls += 1

func _exit_tree():
	get_node("..").walls -= 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func change_monkey(m):
	m.dir = -m.dir


func monkey_leaves(_m):
	pass	
