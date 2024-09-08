extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var right_leaf = preload("res://scenes/ConstructionRightLeaf.tscn")
var up_leaf = preload("res://scenes/ConstructionUpLeaf.tscn")
var left_leaf = preload("res://scenes/ConstructionLeftLeaf.tscn")
var down_leaf = preload("res://scenes/ConstructionDownLeaf.tscn")
var hor_wall = preload("res://scenes/ConstructionHorWall.tscn")
var vert_wall = preload("res://scenes/ConstructionVerticalWall.tscn")
var bed = preload("res://scenes/ConstructionBed.tscn")
var hor_splitter = preload("res://scenes/ConstructionHorizSplitter.tscn")
var vert_splitter = preload("res://scenes/ConstructionVerticalSplitter.tscn")
var real_monkey = preload("res://scenes/Monkey.tscn")
var real_bed = preload("res://scenes/Bed.tscn")
var real_splitter_hor = preload("res://scenes/HorizSplitter.tscn")
var real_splitter_vert = preload("res://scenes/VerticalSplitter.tscn")

var score = 0
var dragging = false
var awake_monkey_count = 2
var minutes_count = 0
var timer = 1
var seen_guide = false
onready var last_2_monkeys1 = get_node("Monkey")
onready var last_2_monkeys2 = get_node("Monkey2")
onready var last_bush = get_node("Bush")

var monkey_max_distance = Vector2(0, 0)
var monkey_min_distance = Vector2(0, 0)

var beds = 0
var monkeys = 0
var walls = 0
var monkey_award = false
var wall_award = false
var shore_award = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_custom_mouse_cursor(load("res://images/cursor_arrow.png"), Input.CURSOR_ARROW, Vector2(16, 16))
	Input.set_custom_mouse_cursor(load("res://images/cursor_hand.png"), Input.CURSOR_POINTING_HAND, Vector2(16, 16))
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	
func _physics_process(delta):
	if monkeys >= 16 and not monkey_award:
		monkey_award = true
		get_node("CanvasLayer/MonkeyAwardPanel").popup()
	if walls >= 20 and not wall_award:
		wall_award = true
		get_node("CanvasLayer/WallAwardPanel").popup()
	if not Input.is_action_pressed("left_click"):
		dragging = false
	var ts = get_timescale()
	timer = max(timer-delta, 0)
	minutes_count += ts*delta/60
	get_node("CanvasLayer/Score/Monkeys").text = str(monkeys)+"/"+str(beds)
	get_node("CanvasLayer/Score/Label").text = "%10.2f" % minutes_count
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

func create_construct(i):
	i.position = get_global_mouse_position()
	i.dragging = true
	dragging = true
	i.has_mouse = true
	i.offset_drag = Vector2(0,0)
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	call_deferred("add_child", i)
	i.call_deferred("change_buddy", "Layer2")
	get_node("CanvasLayer/Commands").hide()
	get_node("CanvasLayer/BuildMenu").show()

func _on_RightLeaf_button_down():
	create_construct(right_leaf.instance())


func _on_BuildMenu_pressed():
	var n = get_node("CanvasLayer/Commands")
	if n.is_visible():
		n.hide()
	else:
		get_node("CanvasLayer/Story").hide()
		get_node("CanvasLayer/GuideMenu").hide()
		n.show()
	#get_node("CanvasLayer/BuildMenu").hide()


func _on_UpLeaf_button_down():
	create_construct(up_leaf.instance())


func _on_LeftLeaf_button_down():
	create_construct(left_leaf.instance())


func _on_DownLeaf_button_down():
	create_construct(down_leaf.instance())


func _on_HorizWall_button_down():
	create_construct(hor_wall.instance())


func _on_VerticalWall_button_down():
	create_construct(vert_wall.instance())


func _on_Bed_button_down():
	create_construct(bed.instance())


func _on_HorizSplitter_button_down():
	create_construct(hor_splitter.instance())


func _on_VerticalSplitter_button_down():
	create_construct(vert_splitter.instance())


func _on_HoverCursor_mouse_entered():
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	
func _on_HoverCursor_mouse_exited():
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func compute_explored():
	var minx =-14706
	var maxx = 14990
	var pos = $ExploredArea/CollisionShape2D.position
	var ext = $ExploredArea/CollisionShape2D.shape.extents
	var miny= -13217
	var maxy = 16478
	var xper1 = abs(-1+2*(pos.x - minx)/(maxx-minx))
	var yper1 = abs(-1+2*(pos.y - miny)/(maxy-miny))
	var xper2 = abs(-1+2*(pos.x+ext.x - minx)/(maxx-minx))
	var yper2 = abs(-1+2*(pos.y+ext.y - miny)/(maxy-miny))
	var s = max(max(xper1, yper1), max(xper2, yper2))*100
	if s >= 100 and not shore_award:
		shore_award = true
		get_node("CanvasLayer/ShoreAwardPanel").popup()
	return s

func _on_GuideMenu_pressed():
	var n = get_node("CanvasLayer/GuideMenu")
	if n.is_visible():
		n.hide()
	else:
		n.show()
		get_node("CanvasLayer/Commands").hide()
		get_node("CanvasLayer/Story").hide()


func _on_StoryMenuButton_pressed():
	var n = get_node("CanvasLayer/Story")
	if n.is_visible():
		n.hide()
	else:
		get_node("CanvasLayer/Story/StoryPanel/MonkeyGoal").text = str(monkeys)+"/16"
		get_node("CanvasLayer/Story/StoryPanel/WallGoal").text = str(walls)+"/20"
		var s = compute_explored()
		get_node("CanvasLayer/Story/StoryPanel/ShoreGoal").text = "%4.0f" % s+"%"
		n.show()
		get_node("CanvasLayer/GuideMenu").hide()
		get_node("CanvasLayer/Commands").hide()

func _on_StoryPanel_gui_input(event):
	if event.is_action("left_click") and timer == 0:
		get_node("CanvasLayer/Story").hide()
		if not seen_guide:
			timer = 1
			seen_guide = true
			get_node("CanvasLayer/GuideMenu").show()


func _on_GuidePanel_gui_input(event):
	if event.is_action("left_click") and timer == 0:
		get_node("CanvasLayer/GuideMenu").hide()


func _on_Area2D_area_exited(area):
	var mon = area.get_parent().position
	var col = $ExploredArea/CollisionShape2D
	if mon.x < col.position.x:
		col.position.x = mon.x
		col.shape.extents.x = mon.x
	if mon.x > col.position.x + col.shape.extents.x:
		col.shape.extents.x = mon.x
	if mon.y < col.position.y:
		col.position.y = mon.y
		col.shape.extents.y = mon.y
	if mon.y > col.position.y + col.shape.extents.y:
		col.shape.extents.y = mon.y

func change_monkey(_m):
	pass
	
func monkey_leaves(_m):
	pass	


func _on_TextEdit_text_changed():
	if $CanvasLayer/Story/StoryPanel/TextEdit.text == "12ANGRYMONKEYS":
		for i in range(12):
			var a = real_bed.instance()
			a.position = last_bush.position
			add_child_below_node(get_node("Bed"), a)
			a = real_monkey.instance()
			a.position = last_bush.position
			add_child_below_node(get_node("Monkey"), a)
	if $CanvasLayer/Story/StoryPanel/TextEdit.text == "SPLITTERMISS":
		for i in range(6):
			var a = real_splitter_hor.instance()
			a.position = last_bush.position
			add_child_below_node(get_node("Bed"), a)
			a = real_splitter_vert.instance()
			a.position = last_bush.position
			add_child_below_node(get_node("Bed"), a)


func _on_HSlider_value_changed(value):
	if value < -20:
		value = value * (-value/20)
	$AudioStreamPlayer.volume_db = value

func _on_FullArea_area_exited(area):
	compute_explored()
	if not shore_award:
		shore_award = true
		get_node("CanvasLayer/ShoreAwardPanel").popup()
