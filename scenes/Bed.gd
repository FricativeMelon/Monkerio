extends Draggable

export(PackedScene) var monkey = preload("res://scenes/Monkey.tscn")

var current_partner = null

func _init():
	pass

func _ready():
	get_node("..").beds_minus_monkeys += 1

func _exit_tree():
	get_node("..").beds_minus_monkeys -= 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func change_monkey(m):
	if m.left_item == 2:
		m.set_left_item(null)
	if m.right_item == 2:
		m.set_right_item(null)
	if get_node("..").beds_minus_monkeys <= 0:
		return
	if current_partner != null and current_partner.fullness >= 70 and m.fullness >= 70:
		var nm = monkey.instance()
		nm.position = position
		m.fullness -= 50
		current_partner.fullness -= 50
		get_node("..").call_deferred("add_child_below_node", get_node("../Monkey"), nm)
		current_partner = null
	else:
		current_partner = m


func monkey_leaves(_m):
	current_partner = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
