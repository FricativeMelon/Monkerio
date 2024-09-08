extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 30
var dir = Vector2(1, 0)
var moving = true
var left_item = null
var right_item = null

var on_splitter = 0

var fullness = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("..").monkeys += 1
	
func _exit_tree():
	get_node("..").monkeys -= 1
	
func change_monkey(m):
	if on_splitter > 0:
		return
	if left_item != null and m.try_pick_up(left_item):
		set_left_item(null)
	if right_item != null and m.try_pick_up(right_item):
		set_right_item(null)
	
func monkey_leaves(_m):
	pass	

func set_left_item(item):
	if left_item == null and item != null:
		var n = get_node("LeftItem")
		n.region_rect.position.x = 16*(item-1)
		n.show()
	if left_item != null and item == null:
		get_node("LeftItem").hide()
	left_item = item
	
func set_right_item(item):
	if right_item == null and item != null:
		var n = get_node("RightItem")
		n.region_rect.position.x = 16*(item-1)
		n.show()
	if right_item != null and item == null:
		get_node("RightItem").hide()
	right_item = item

func try_sell():
	if left_item != null:
		get_node("..").add_score(left_item)
		set_left_item(null)
	if right_item != null:
		get_node("..").add_score(right_item)
		set_right_item(null)

func try_pick_up(item):
	if item == 1 and fullness <= 70:
		fullness+=30
		return true
	if left_item == null:
		set_left_item(item)
		return true
	elif right_item == null:
		set_right_item(item)
		return true

	else:
		return false

func update_sprite():
	match dir:
		Vector2(1, 0):
			$Sprite.region_rect.position.x = 0
		Vector2(0, -1):
			$Sprite.region_rect.position.x = 64
		Vector2(-1, 0):
			$Sprite.region_rect.position.x = 128
		Vector2(0, 1):
			$Sprite.region_rect.position.x = 192

func _physics_process(delta):
	var ts = get_node("..").get_timescale()
	if moving == false and fullness > 0:
		moving = true
	fullness -= ts*delta
	while fullness <= 70:
		if left_item == 1:
			set_left_item(null)
			fullness+=30
		elif right_item == 1:
			set_right_item(null)
			fullness+=30
			break
		else:
			break
	if fullness <= 0:
		fullness = 0
		moving = false
	get_node("ProgressBar").value = fullness
	if moving:
		position += ts*delta*speed*dir
	update_sprite()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	#if get_node("../Timescale/HSlider").value < 0:
	area.get_parent().change_monkey(self)


func _on_Area2D_area_exited(area):
	area.get_parent().monkey_leaves(self)
