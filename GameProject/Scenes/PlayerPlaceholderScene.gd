extends KinematicBody2D

var motion = Vector2()
var collision
const SPEED = 300

func _ready():
	get_parent().get_node('Canvas/info').visible = false
	get_parent().get_node("Canvas/Instruction01").visible = false
	get_parent().get_node("Canvas/Instruction02").visible = false
	get_parent().get_node("toInstruction01").connect("timeout", self, "showInstruction01")
	get_parent().get_node("Canvas/Instruction01/fadeAway").connect("timeout", self, "fadeInstruction01Away")
	
func _physics_process(delta):
	collision = null
	motion.x = 0
	motion.y = 0
	
	if !global.pause:
		if Input.is_action_pressed("ui_down"):
			motion.y = SPEED
		
		if Input.is_action_pressed("ui_up"):
			motion.y = -SPEED
			
		if Input.is_action_pressed("ui_right"):
			motion.x = SPEED
			
		if Input.is_action_pressed("ui_left"):
			motion.x = -SPEED
			
	collision = move_and_collide(motion*delta)

	if Input.is_action_just_released("ui_page_up") and get_parent().get_node('Canvas/info').visible == true:
		get_parent().get_node('Canvas/info').visible = false
		global.pause = false
	elif Input.is_action_just_released("ui_page_up"):
		get_parent().get_node('Canvas/info').visible = true
		global.pause = true
		
func showInstruction01():
	get_parent().get_node("Canvas/Instruction01").visible = true
	get_parent().get_node("Canvas/Instruction01/fadeAway").start()
	
func fadeInstruction01Away():
	get_parent().get_node("Canvas/Instruction01").visible = false