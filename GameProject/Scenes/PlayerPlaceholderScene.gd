extends KinematicBody2D

var motion = Vector2()
var dialogEnterCounter = 0
var dialogPassControl = false
const SPEED = 300

func _ready():
	get_parent().get_node('Canvas/info').visible = false
	get_parent().get_node("DialogBoxes/01").visible = false
	get_parent().get_node("DialogBoxes/02").visible = false
	get_parent().get_node("Canvas/Instruction01").visible = false
	get_parent().get_node("Guard01Interaction").visible = false
	get_parent().get_node("Canvas/Instruction02").visible = false
	get_parent().get_node('DialogStart').connect("timeout", self, "startDialog")
	get_parent().get_node('Canvas/Instruction01/toInstruction02').connect("timeout", self, "showInstruction02")
	get_parent().get_node('Guard01Interaction/InteractionEnd').connect("timeout", self, "endInteraction")

func _physics_process(delta):
	var collision
	
	motion.x = 0
	motion.y = 0
	
	if Input.is_action_pressed("ui_down"):
		motion.y = SPEED
	
	if Input.is_action_pressed("ui_up"):
		motion.y = -SPEED
		
	if Input.is_action_pressed("ui_right"):
		motion.x = SPEED
		
	if Input.is_action_pressed("ui_left"):
		motion.x = -SPEED
		
	collision = move_and_collide(motion*delta)
	
	if collision:
		if collision.collider.name == 'Porta01' and Input.is_action_pressed("ui_interact"):
			print('Porta01 colidida')
			collision.collider.queue_free()
		if collision.collider.name == 'Guard01' and Input.is_action_pressed("ui_interact"):
			get_parent().get_node("Guard01Interaction").visible = true
			get_parent().get_node("Guard01Interaction/InteractionEnd").start()
			

	if Input.is_action_just_released("ui_page_up") and get_parent().get_node('Canvas/info').visible == true:
		get_parent().get_node('Canvas/info').visible = false
	elif Input.is_action_just_released("ui_page_up"):
		get_parent().get_node('Canvas/info').visible = true
		
	if Input.is_action_just_released("ui_accept") and dialogPassControl:
		if dialogEnterCounter == 0:
			print('cheguei no dialog counter')
			get_parent().get_node("DialogBoxes/01").visible = false
			get_parent().get_node("DialogBoxes/02").visible = true
			dialogEnterCounter += 1
		elif dialogEnterCounter == 1:
			get_parent().get_node("DialogBoxes/02").visible = false
			get_parent().get_node("Canvas/Instruction01").visible = true
			dialogEnterCounter += 1
		elif dialogEnterCounter == 2:
			get_parent().get_node("Canvas/Instruction01").visible = false
			get_parent().get_node("Canvas/Instruction01/toInstruction02").start()
			dialogEnterCounter += 1
		elif get_parent().get_node("Canvas/Instruction02").visible == true:
			get_parent().get_node("Canvas/Instruction02").visible = false

func startDialog():
	get_parent().get_node("DialogBoxes/01").visible = true
	dialogPassControl = true

func endInteraction():
	get_parent().get_node("Guard01Interaction").visible = false
	
func showInstruction02():
	get_parent().get_node("Canvas/Instruction02").visible = true