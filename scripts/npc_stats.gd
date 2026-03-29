extends Node

const stat_label = preload("res://components/characters/npc_stat_label.tscn")

var self_index = 0 #change but howwww??
var spacing = 40

func _ready():
	var friends = Game.chars[self_index]
	for friend in friends:
		if not friend == "name":
			spacing += 20
			var lbl = stat_label.instantiate()
			add_child(lbl)
			lbl.global_position = Vector2i(self.global_position.x, self.global_position.y+spacing)
			lbl.text = friend + ": " + str(Game.chars[self_index][friend])
