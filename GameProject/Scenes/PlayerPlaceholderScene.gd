extends KinematicBody2D

var motion = Vector2()
const SPEED = 1000
var elementsQuizProgress = 0

func _ready():
	get_parent().get_node("Canvas/info").visible = false
	get_parent().get_node("Canvas/Instruction01").visible = false
	get_parent().get_node("Canvas/Instruction02").visible = false
	closeSoulsDlg()
	get_parent().get_node("toInstruction01").connect("timeout", self, "showInstruction01")
	get_parent().get_node("Canvas/Instruction01/fadeAway").connect("timeout", self, "fadeInstruction01Away")
	get_parent().get_node("dlgEnd").connect("timeout", self, "closeSoulsDlg")
	get_parent().get_node("Canvas/mistakeMsgEnd").connect("timeout", self, "fadeOutMistakeMsg")
	
func _physics_process(delta):
	var collision
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
			
	if collision:
		if collision.collider.name == 'Soul1' and Input.is_action_pressed("ui_interact"):
			get_parent().get_node("Souls/Soul1/dlg").visible = true
			get_parent().get_node("dlgEnd").start()
		elif collision.collider.name == 'Soul2' and Input.is_action_pressed("ui_interact"):
			get_parent().get_node("Souls/Soul2/dlg").visible = true
			get_parent().get_node("dlgEnd").start()
		elif collision.collider.name == 'Soul3' and Input.is_action_pressed("ui_interact"):
			get_parent().get_node("Souls/Soul3/dlg").visible = true
			get_parent().get_node("dlgEnd").start()
		elif collision.collider.name == 'Soul4' and Input.is_action_pressed("ui_interact"):
			get_parent().get_node("Souls/Soul4/dlg").visible = true
			get_parent().get_node("dlgEnd").start()
		elif collision.collider.name == 'Soul5' and Input.is_action_pressed("ui_interact"):
			get_parent().get_node("Souls/Soul5/dlg").visible = true
			get_parent().get_node("dlgEnd").start()
		elif collision.collider.name == 'Soul6' and Input.is_action_pressed("ui_interact"):
			get_parent().get_node("Souls/Soul6/dlg").visible = true
			get_parent().get_node("dlgEnd").start()
		elif collision.collider.name == 'Soul7' and Input.is_action_pressed("ui_interact"):
			get_parent().get_node("Souls/Soul7/dlg").visible = true
			get_parent().get_node("dlgEnd").start()
			
		if collision.collider.name == "Fogo" and Input.is_action_just_released("ui_interact"):
			if elementsQuizProgress == 0:
				elementsQuizProgress += 1
			else:
				elementsQuizProgress = 0
				get_parent().get_node("Canvas/Mistake").visible = true
				get_parent().get_node("Canvas/mistakeMsgEnd").start()
		
		if collision.collider.name == "Agua" and Input.is_action_just_released("ui_interact"):
			if elementsQuizProgress == 1:
				elementsQuizProgress += 1
			else:
				elementsQuizProgress = 0
				get_parent().get_node("Canvas/Mistake").visible = true
				get_parent().get_node("Canvas/mistakeMsgEnd").start()
				
		if collision.collider.name == "Terra" and Input.is_action_just_released("ui_interact"):
			if elementsQuizProgress == 2:
				elementsQuizProgress += 1
			else:
				elementsQuizProgress = 0
				get_parent().get_node("Canvas/Mistake").visible = true
				get_parent().get_node("Canvas/mistakeMsgEnd").start()
				
		if collision.collider.name == "Ar" and Input.is_action_just_released("ui_interact"):
			if elementsQuizProgress == 3:
				elementsQuizProgress += 1
			else:
				elementsQuizProgress = 0
				get_parent().get_node("Canvas/Mistake").visible = true
				get_parent().get_node("Canvas/mistakeMsgEnd").start()
			
	if elementsQuizProgress == 4:
		var finalDoor = get_parent().get_node("FinalDoor")
		finalDoor.visible = false
		finalDoor.get_node("CollisionShape2D").disabled = true
		
	if Input.is_action_pressed("ui_accept"):
		closeSoulsDlg()
			

	if Input.is_action_just_released("ui_info") and get_parent().get_node('Canvas/info').visible == true:
		get_parent().get_node('Canvas/info').visible = false
		global.pause = false
	elif Input.is_action_just_released("ui_info"):
		get_parent().get_node('Canvas/info').visible = true
		global.pause = true
		
func fadeOutMistakeMsg():
	get_parent().get_node("Canvas/Mistake").visible = false
		
func closeSoulsDlg():
	for soul in get_parent().get_node("Souls").get_children():
		soul.get_node("dlg").visible = false
		
func showInstruction01():
	get_parent().get_node("Canvas/Instruction01").visible = true
	get_parent().get_node("Canvas/Instruction01/fadeAway").start()
	
func fadeInstruction01Away():
	get_parent().get_node("Canvas/Instruction01").visible = false
	
