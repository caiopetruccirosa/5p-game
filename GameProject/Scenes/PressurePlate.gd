extends Area2D

func _ready():
	pass

func _on_PressurePlate_body_entered(body):
	$closeDoorTimer.start()
	var ironDoor = get_parent().get_node("IronDoor")
	ironDoor.global_position = Vector2(-1000, -1000)
	

func _on_closeDoorTimer_timeout():
	var ironDoor = get_parent().get_node("IronDoor")
	ironDoor.global_position = Vector2(357.156, 2581.14)
	
