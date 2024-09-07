extends Draggable


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Vector2) var dir

func _init(p_dir = Vector2(0, -1)):
	dir = p_dir

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func change_monkey(m):
	m.dir = dir
	dir = -dir
	$Sprite.region_rect.position.x = int($Sprite.region_rect.position.x + 128)%256
	
func monkey_leaves(_m):
	pass	
