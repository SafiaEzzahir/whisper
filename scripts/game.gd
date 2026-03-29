extends Node

const char_node = preload("res://components/characters/npc.tscn")
const char_images = [preload("res://art/npc1.png"), preload("res://art/npc2.png")]


var random = RandomNumberGenerator.new()

var order = []
# player chooses character names
var chars = [
	{"name": "louisa"},
	{"name": "safia"}, 
	{"name": "mellina"},
	{"name": "hassan"}
]

var char_nodes = []
var nodes_created = false

func _ready() -> void:
	# generate random seeeeeeedddddd
	random.randomize()
	# generate correct order thingy
	order = generate_order()
	
func generate_order():
	# generate the characters' friendships and stuff
	var chars = generate_chars()
	
func generate_chars():
	for char in chars:
		for other_char in chars:
			if other_char != char:
				var other_char_name = other_char["name"]
				char[other_char_name] = randi() % 6

func instantiate_char_sprite():
	if !nodes_created:
		for i in Game.chars:
			var c = char_node.instantiate()
			c.get_node("body/sprite").texture = char_images[randi() % 2]
			c.get_node("body").position = Vector2i(randi() % 1000, randi() % 1000)
			c.npc_name = i["name"]
			char_nodes.append(c)
			add_child(c)
		nodes_created = true
	else:
		for node in Game.char_nodes:
			add_child(node)
		
func disinstantiate_char_sprite():
	print(Game.char_nodes)
	for char_node in char_nodes:
		remove_child(char_node)
