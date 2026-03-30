extends Node

const char_node = preload("res://components/characters/npc.tscn")
const char_images = [preload("res://art/npc1.png"), preload("res://art/npc2.png")]

const poses = [Vector2(18, 28), Vector2(240, 394), Vector2(683, 107), Vector2(1211, 110), Vector2(877, 466), Vector2(537, 871), Vector2(765, 571), Vector2(28, 554), Vector2(484, 452), Vector2(879, 658)] #10

var random = RandomNumberGenerator.new()

var order = []
var next_combo_index = 0

# player chooses character names
var chars = [
	{"name": "louisa"},
	{"name": "safia"}, 
	{"name": "mellina"},
	{"name": "hassan"}
]

var char_nodes = []
var nodes_created = false

var outside_node = null

func _ready() -> void:
	order = []
	chars = [
		{"name": "louisa"},
		{"name": "safia"}, 
		{"name": "mellina"},
		{"name": "hassan"}
	]

	char_nodes = []
	nodes_created = false
	random.randomize()
	order = generate_order()
	
func generate_order():
	generate_chars()
	
	var l = len(chars)
	var first = chars[random.randi_range(0, l - 1)]
	order.append(first["name"])
	
	choose_next(first)
	
	print(order)
	order.reverse()
	outside_node = order[0]
	return order

func choose_next(current):
	if order.size() >= chars.size():
		return
	
	var best_name = null
	var best_score = -1
	
	for key in current.keys():
		if key == "name":
			continue
		
		if key in order:
			continue
		
		var score = current[key]
		
		if score > best_score:
			best_score = score
			best_name = key
	
	if best_name != null:
		order.append(best_name)
		
		for c in chars:
			if c["name"] == best_name:
				choose_next(c)
				return

func generate_chars():
	for char in chars:
		for other_char in chars:
			if other_char != char:
				var other_char_name = other_char["name"]
				char[other_char_name] = randi() % 6
				
	print(chars)

func instantiate_char_sprite():
	if !nodes_created:
		var available_poses = poses.duplicate()
		
		for idx in range(Game.chars.size()):
			var i = Game.chars[idx]
			if outside_node != i["name"]:
				var c = char_node.instantiate()
				
				c.get_node("body/sprite").texture = char_images[random.randi_range(0, char_images.size() - 1)]
				
				if available_poses.size() > 0:
					var pos_index = random.randi_range(0, available_poses.size() - 1)
					c.get_node("body").position = available_poses[pos_index]
					available_poses.remove_at(pos_index)
				else:
					c.get_node("body").position = Vector2.ZERO
				
				c.npc_name = i["name"]
				c.npc_index = idx 
				char_nodes.append(c)
				add_child(c)

		nodes_created = true
	else:
		for node in Game.char_nodes:
			add_child(node)

func instantiate_outside_char():
	if outside_node == null:
		return

	for i in chars:
		if i["name"] == outside_node:
			var c = char_node.instantiate()
			c.get_node("body/sprite").texture = char_images[random.randi_range(0, char_images.size() - 1)]
			var pos_index = random.randi_range(0, poses.size() - 1)
			c.get_node("body").position = poses[pos_index]
			c.npc_name = i["name"]
			c.npc_index = chars.find(i)
			add_child(c)
			break
		
func disinstantiate_char_sprite():
	print(Game.char_nodes)
	for n in char_nodes:
		remove_child(n)

func combo(npc_name, node):
	if next_combo_index < len(chars):
		if npc_name == chars[next_combo_index]["name"]:
			next_combo_index += 1
			node.light_up()
			print("correct")
