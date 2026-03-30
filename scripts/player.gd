extends CharacterBody2D

const hintnode = preload("res://components/player/hint.tscn")

var speed = 300
var hint_created = false

func _ready():
	$hint.pressed.connect(hint_func)

func _process(delta: float) -> void:
	_move(delta)
	$AnimatedSprite2D.play("default")
	
	
func _move(delta):
	var position_change = Input.get_vector("left", "right", "up", "down") * speed * delta
	velocity = position_change * speed
	move_and_slide()
	return position_change

func hint_func():
	if not hint_created:
		hint_created = hintnode.instantiate()
		$hint.add_child(hint_created)
	else:
		$hint.remove_child(hint_created)
		hint_created = false
