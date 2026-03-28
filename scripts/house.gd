extends Node

var time_since_entered = 0
var counting = false

var time_limit = 2

func _process(delta: float):
	if counting:
		time_since_entered += delta
		if time_since_entered >= time_limit:
			get_tree().change_scene_to_file("res://components/houses/inside_house.tscn")
	

func _on_body_entered(_body: Node2D) -> void:
	counting = true


func _on_body_exited(_body: Node2D) -> void:
	counting = false
	time_since_entered = 0
