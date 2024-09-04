extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var has_mouse = false
var dragging = false
var offset_drag = Vector2(0, 0)

func _init():
	pass
func _process(delta):
	if (has_mouse and Input.is_action_pressed("left_click")):
		offset_drag = global_position - get_global_mouse_position()
		dragging = true
	if not Input.is_action_pressed("left_click"):
		dragging = false
	if dragging:
		global_position = global_position.linear_interpolate(get_global_mouse_position() +offset_drag, 10*delta)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func change_monkey(m):
	m.dir = -m.dir


func _on_Area2D_mouse_entered():
	has_mouse = true
	pass # Replace with function body.


func _on_Area2D_mouse_exited():
	has_mouse = false
	pass # Replace with function body.
