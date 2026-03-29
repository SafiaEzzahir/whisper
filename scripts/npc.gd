extends Node

const npc_stats_scene = preload("res://components/characters/npc_stats.tscn")

signal change_scene

var time_since_entered = 0
var counting = false

var stats = null

var time_limit = 2

var npc_name = "bob"

func _process(delta: float):
	if counting:
		time_since_entered += delta
		if time_since_entered >= time_limit:
			if not stats:
				enter_npc()
			#get_tree().change_scene_to_file("res://scenes/game.tscn")
			#Game.disinstantiate_char_sprite()
	

func _on_body_entered(_body: Node2D) -> void:
	counting = true


func _on_body_exited(_body: Node2D) -> void:
	counting = false
	time_since_entered = 0
	if stats:
		remove_child(stats)
		stats = null
	
func enter_npc():
	stats = npc_stats_scene.instantiate()
	stats.position = $body.position
	print(npc_name)
	stats.get_node("name").text = npc_name
	add_child(stats)
