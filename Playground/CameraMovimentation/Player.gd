extends KinematicBody2D

var motion = Vector2()
const SPEED = 300

func _ready():
	pass

func _physics_process(delta):
	motion.x = 0
	motion.y = 0
	
	if Input.is_action_pressed("ui_down"):
		motion.y = SPEED
	elif Input.is_action_pressed("ui_up"):
		motion.y = -SPEED
	elif Input.is_action_pressed("ui_right"):
		motion.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		
	move_and_slide(motion)