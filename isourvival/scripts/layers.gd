extends Node2D

const MAX_HEIGHT = 4
const WORLD_SIZE = 100

var tileType = {
	"grass": Vector2(0,0),
	"mud": Vector2(1,0),
	"snow": Vector2(2,0),
	"sand": Vector2(0,1),
	"water": Vector2(1,1),
}

func _ready() -> void:
	var noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.seed = randi()
	noise.frequency = .05
	
	for i in range(MAX_HEIGHT):
		var layer = TileMapLayer.new()
		layer.tile_set = load("res://assets/tileset.tres")
		layer.y_sort_enabled = true
		layer.position.y -= i*8
		layer.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
		
		var tile = tileType["mud"]
		if i >= 1: tile = tileType["grass"]
		elif i == 5: tile = tileType["snow"]
		
		var threshold = -1.0 + (2.0 / MAX_HEIGHT) * (i + 1)
		
		for x in range (-WORLD_SIZE/2, WORLD_SIZE/2):
			for y in range (-WORLD_SIZE, WORLD_SIZE):
				var value = noise.get_noise_2d(x,y)
				if value > threshold:
					layer.set_cell(Vector2(x,y),0,tile)
				elif i == 0:
					layer.set_cell(Vector2(x,y),0,tileType["water"])

		add_child(layer)
