extends Draggable


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Vector2) var dir

func _init(p_dir = Vector2(1, 0)):
	dir = p_dir

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func change_monkey(m):
	m.dir = dir
	
func monkey_leaves(m):
	pass	
