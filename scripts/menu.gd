extends Node

const char_node = preload("res://components/characters/npc.tscn")
const char_images = [preload("res://art/npc1.png"), preload("res://art/npc2.png")]

const new_char_thing = preload("res://components/characters/new_char.tscn")

var poses = [Vector2(114, 183), Vector2(114, 286), Vector2(114, 388), Vector2(114, 481), Vector2(114, 586), Vector2(809, 183), Vector2(809, 286), Vector2(809, 388), Vector2(809, 481), Vector2(809, 586)]

var chs = []

func _ready():
	$add.pressed.connect(add)
	$play.pressed.connect(play)
	
func add():
	if len(chs) < 10:
		var c = new_char_thing.instantiate()
		c.position = poses.pop_front()
		chs.append(c)
		add_child(c)

func play():
	if no_duplicates():
		for ch in chs:
			Game.chars.append({"name": ch.get_node("name").text, "img":ch.get_node("change_img").icon})
	Game.start()
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func no_duplicates():
	return true
