extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var score = 0
var dragging = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_custom_mouse_cursor(load("res://images/cursor_arrow.png"), Input.CURSOR_ARROW, Vector2(16, 16))
	Input.set_custom_mouse_cursor(load("res://images/cursor_hand.png"), Input.CURSOR_POINTING_HAND, Vector2(16, 16))

func get_timescale():
	var ts = get_node("CanvasLayer/Timescale/HSlider").value
	if ts > 0:
		ts = pow(2, ts-1)
	return ts

func add_score(s):
	score+=s
	get_node("CanvasLayer/Score/Label").text = str(score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
