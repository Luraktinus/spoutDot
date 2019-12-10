class_name WorldGenerator extends Node2D

onready var pixelblock = preload('res://PixelBlock.tscn')
onready var blocks = $"../Blocks"

const CHUNK_SIZE = 100
const PREGEN = 2
var generated_chunks = 0
var rand = RandomNumberGenerator.new()
var high_pos = 0
var new_high_pos = 0

const PIXEL_BLOCK_SIZE = 2


func _ready():
	#generate 10000 pixelblocks
	for i in range(10000):
		var p = pixelblock.instance()
		p.deactivate()
		blocks.add_child(p)
	
	rand.seed = 5
	for i in range(PREGEN):
		generate_chunk(i)


func rir(mini, maxi):
	return rand.randi_range(mini, maxi)


func _physics_process(delta):
	var players = get_tree().get_nodes_in_group('Players')
	for player in players:
		var p = int(-player.position.y)
		if p > high_pos:
			new_high_pos = p
			if (new_high_pos + 2*CHUNK_SIZE) / CHUNK_SIZE + PREGEN -1 > generated_chunks:
				generate_chunk(generated_chunks)
			high_pos = new_high_pos


func generate_chunk(c):
	print('generating CHUNK ', c)
	generated_chunks += 1
	var start = -1*c*CHUNK_SIZE
	for i in range((start - CHUNK_SIZE) / PIXEL_BLOCK_SIZE, start / PIXEL_BLOCK_SIZE):
		for x in range(3):
			var p = get_tree().get_nodes_in_group('InactiveBlocks')[0]
			var pos = Vector2(x * PIXEL_BLOCK_SIZE +16, i * PIXEL_BLOCK_SIZE)
			p.activate(pos, str(c))
	
	if rir(0,10) > 5:
		var off_x = rir(-400, 400)
		var x_range = [rir(-60, 0), rir(0, 60)]
		var y_range = [rir(1, -90), rir(-1, -30)]
		for x in range(x_range[0], x_range[1]):
			for y in range((y_range[0] + y_range[1]) / PIXEL_BLOCK_SIZE, y_range[0] / PIXEL_BLOCK_SIZE):
				var p = get_tree().get_nodes_in_group('InactiveBlocks')[0]
				var pos = Vector2(x * PIXEL_BLOCK_SIZE + off_x, y * PIXEL_BLOCK_SIZE + -c * CHUNK_SIZE)
				p.activate(pos, str(c))
	
	if c >= 4:
		var chunk_rm = c-4
		print('deleting CHUNK ', chunk_rm)
		for block in get_tree().get_nodes_in_group(str(chunk_rm)):
			block.deactivate()


