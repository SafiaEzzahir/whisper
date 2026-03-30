extends Node

const stat_label = preload("res://components/characters/npc_stat_label.tscn")

var rent
var self_index

var spacing = 40

func _ready():
	rent = get_parent()
	self_index = rent.npc_index
	
	var friends = Game.chars[self_index]
	for friend in friends:
		if not friend == "name" and not friend == "img":
			spacing += 20
			var lbl = stat_label.instantiate()
			add_child(lbl)
			lbl.global_position = Vector2i(self.global_position.x, self.global_position.y+spacing)
			lbl.text = friend + ": " + str(Game.chars[self_index][friend])
