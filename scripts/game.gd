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

func _ready() -> void:
	# generate random seeeeeeedddddd
	random.randomize()
	# generate correct order thingy
	order = generate_order()
	
	instantiate_char_sprite()
	
func generate_order():
	# generate the characters' friendships and stuff
	chars = generate_chars()
	
func generate_chars():
	for char in chars:
		for other_char in chars:
			if other_char != char:
				var other_char_name = other_char["name"]
				char[other_char_name] = randi() % 6
				print(char)
			print(char)
		print(char)
	print(chars)

func instantiate_char_sprite():
	for i in chars:
		var c = char_node.instantiate()
		c.get_node("body/sprite").texture = char_images[randi() % 2]	
