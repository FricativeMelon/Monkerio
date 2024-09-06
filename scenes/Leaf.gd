extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(Vector2) var dir
var has_mouse = false
var dragging = false
var offset_drag = Vector2(0, 0)

func _init(p_dir = Vector2(1, 0)):
	dir = p_dir

func _process(delta):
	if (has_mouse and Input.is_action_pressed("left_click") and not get_node("..").dragging):
		offset_drag = global_position - get_global_mouse_position()
		dragging = true
		get_node("..").dragging = true
	if not Input.is_action_pressed("left_click"):
		dragging = false
		get_node("..").dragging = false
	if dragging:
		global_position = global_position.linear_interpolate(get_global_mouse_position() +offset_drag, 10*delta)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func change_monkey(m):
	m.dir = dir


func _on_Area2D_mouse_entered():
	has_mouse = true
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	pass # Replace with function body.


func _on_Area2D_mouse_exited():
	has_mouse = false
	if dragging == false:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	pass # Replace with function body.
