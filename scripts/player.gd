extends CharacterBody2D

var speed = 300

func _process(delta: float) -> void:
	_move(delta)
	$AnimatedSprite2D.play("default")
	
	
func _move(delta):
	var position_change = Input.get_vector("left", "right", "up", "down") * speed * delta
	velocity = position_change * speed
	move_and_slide()
	return position_change
