extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#export(Vector2) var charged_movement = Vector2(0,0)
#var speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#	if charged_movement == Vector2(0,0):
#		return
#	var to_move = speed*delta*charged_movement.direction_to(Vector2(0,0))
#	if charged_movement.x - to_move.x :
#		to_move.x += charged_movement.x
#		charged_movement.x = 0
#	if charged_movement.y < 0:
#		to_move.y += charged_movement.y
#		charged_movement.y = 0
#	charged_movement -= to_move
#	position += to_move

func _unhandled_input(event):
	if event.is_action("camera_left"):
		position.x -= 50*zoom.x
	if event.is_action("camera_right"):
		position.x += 50*zoom.x
	if event.is_action("camera_up"):
		position.y -= 50*zoom.y
	if event.is_action("camera_down"):
		position.y += 50*zoom.y
	if event.is_action("camera_zoom_in"):
		zoom.y = clamp(zoom.y/2, 1, 16)
		zoom.x = clamp(zoom.x/2, 1, 16)
	if event.is_action("camera_zoom_out"):
		zoom.y = clamp(zoom.y*2, 1, 16)
		zoom.x = clamp(zoom.x*2, 1, 16)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
