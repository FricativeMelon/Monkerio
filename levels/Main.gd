extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var right_leaf = preload("res://scenes/ConstructionRightLeaf.tscn")

var score = 0
var dragging = false
var awake_monkey_count = 2
var minutes_count = 0
onready var last_2_monkeys1 = get_node("Monkey")
onready var last_2_monkeys2 = get_node("Monkey2")
onready var last_bush = get_node("Bush")

var beds_minus_monkeys = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_custom_mouse_cursor(load("res://images/cursor_arrow.png"), Input.CURSOR_ARROW, Vector2(16, 16))
	Input.set_custom_mouse_cursor(load("res://images/cursor_hand.png"), Input.CURSOR_POINTING_HAND, Vector2(16, 16))

func _physics_process(delta):
	var ts = get_timescale()
	minutes_count += ts*delta/60
	get_node("CanvasLayer/Score/Label").text = str(minutes_count)
	if not last_2_monkeys1.moving and not last_2_monkeys2.moving:
		get_node("CanvasLayer/Button").disabled = false
	else:
		get_node("CanvasLayer/Button").disabled = true

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


func _on_Button_pressed():
	last_2_monkeys1.position = last_bush.position
	last_2_monkeys2.position = last_bush.position+Vector2(20, 0)
	get_node("MyCamera").position = last_bush.position
	last_bush.change_monkey(last_2_monkeys1)
	last_bush.change_monkey(last_2_monkeys2)

func _on_RightLeaf_button_down():
	var i = right_leaf.instance()
	i.position = get_global_mouse_position()
	i.dragging = true
	dragging = true
	i.has_mouse = true
	i.offset_drag = Vector2(0,0)
	call_deferred("add_child", i)
	i.call_deferred("change_buddy", "Layer2")
	get_node("CanvasLayer/Commands").hide()
	get_node("CanvasLayer/BuildMenu").show()


func _on_BuildMenu_pressed():
	get_node("CanvasLayer/Commands").show()
	get_node("CanvasLayer/BuildMenu").hide()
