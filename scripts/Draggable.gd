extends Node2D

class_name Draggable

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var has_mouse = false
var dragging = false
var offset_drag = Vector2(0, 0)

func get_real_top():
	return get_tree().root.get_child(0)

func change_buddy(np):
	var parent = get_parent()
	var pos_in_parent = parent.get_node(np).get_position_in_parent()
	parent.move_child(self, pos_in_parent)

func _process(delta):
	if (has_mouse and Input.is_action_pressed("left_click") and not get_real_top().dragging):
		offset_drag = global_position - get_global_mouse_position()
		dragging = true
		get_real_top().dragging = true
		change_buddy("Layer2")
	if not Input.is_action_pressed("left_click") and dragging:
		dragging = false
		get_real_top().dragging = false
		change_buddy("Layer1")
	if dragging:
		global_position = global_position.linear_interpolate(get_global_mouse_position() +offset_drag, 10*delta)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Area2D_mouse_entered():
	has_mouse = true
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_Area2D_mouse_exited():
	has_mouse = false
	if dragging == false:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
