extends TileMap

var tile
var noise := OpenSimplexNoise.new()
var width = 128
var height = 1000


func _ready():
	randomize()
	noise.seed = int(randi())
	print(noise.seed)
	
	create_noise(-width/2,-height-20,width,height)


func _process(_delta):
	#$Camera2D.position += (get_global_mouse_position()-$Camera2D.position)*delta
	pass


func _on_particle_collided(pos, normal):
	var tile_pos = self.world_to_map(pos - normal)
	self.set_cellv(tile_pos, -1)


func create_noise(x_pos,y_pos,width,height):
	for x in range(width):
		for y in range(height):
			tile = -1
			var noise_value = 0
			noise_value += noise.get_noise_2d((x+x_pos)*0.2,      (y+y_pos)*0.2)*0.2
			noise_value += noise.get_noise_2d((x+x_pos+ 500)*1,   (y+y_pos)*1)*0.5
			noise_value += noise.get_noise_2d((x+x_pos+1000)*1.1, (y+y_pos)*1.2)*0.5
			noise_value -= noise.get_noise_2d((x+x_pos+1500)*1.8,   (y+y_pos)*2)*0.3
			if noise_value > 0.1: #-sqrt(x*x+y*y)*0.0015:
				tile = 0
			set_cell(x + x_pos, y + y_pos, tile)




