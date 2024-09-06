extends Draggable


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var node_construct = preload("res://scenes/DownLeaf.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func monkey_leaves(_m):
	pass

func change_monkey(m):
	if m.left_item == 1 and m.right_item == 1:
		m.set_left_item(null)
		m.set_right_item(null)
		var i = node_construct.instance()
		i.position = position
		i.dir = Vector2(0, 1)
		var parent = get_parent()
		var pos_in_parent = get_position_in_parent()
		parent.remove_child(self)
		parent.call_deferred("add_child", i)
		parent.call_deferred("move_child", i, pos_in_parent)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

