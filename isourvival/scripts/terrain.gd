extends Node2D

const MAX_HEIGHT = 4

enum Type {WATER, MUD, GRASS, SNOW}

class Tile:
	var index
	var position : Vector2
	var type_coords : Vector2
	var air : bool = false
	
	func _init(x, y, layer_height, noise_value):
		index = x+y* globals.WORLD_WIDTH
		position = Vector2(x, y)
		
		if noise_value > 0.8 * MAX_HEIGHT:
			set_type_coords(Type.SNOW)
		elif noise_value > 0.3 * MAX_HEIGHT :
			set_type_coords(Type.GRASS)
		elif layer_height == 0 and noise_value < 0.2 * MAX_HEIGHT:
			set_type_coords(Type.WATER)
		else:
			set_type_coords(Type.MUD)
	
	func set_type_coords(t : Type):
		match t:
			Type.WATER:
				type_coords = Vector2(1,1)
			Type.MUD:
				type_coords = Vector2(1,0)
			Type.GRASS:
				type_coords = Vector2(0,0)
			Type.SNOW:
				type_coords = Vector2(2,0)

func _ready() -> void:
	var layersData = []
	var topLayers = []
	layersData.resize(MAX_HEIGHT)
	topLayers.resize(MAX_HEIGHT)
	
	var noise = makeNoise(0.009)
	
	for layer_height in range(MAX_HEIGHT-1, -1, -1):
		var layerData = []
		var topLayer = makeLayer(layer_height)
		
		for y in range (globals.WORLD_HEIGHT*2):
			for x in range (globals.WORLD_WIDTH):
				
				var noise_value = (noise.get_noise_2d(x*2.0,y) + 1.0) / 2.0 * MAX_HEIGHT
				var tile = Tile.new(x, y, layer_height, noise_value)
				
				if noise_value > layer_height:
					if layer_height == MAX_HEIGHT-1:
						topLayer.set_cell(tile.position,0,tile.type_coords)
					elif layersData[layer_height+1][tile.index].air == true:
						topLayer.set_cell(tile.position,0,tile.type_coords)
				else:
					tile.air = true
				
				layerData.append(tile)
		
		layersData[layer_height] = layerData
		topLayers[layer_height] = topLayer
		
	for layer in topLayers:
		add_child(layer)

func makeNoise(frequency):
	var noise = FastNoiseLite.new()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.seed = randi()
	noise.frequency = frequency
	return noise

func makeLayer(index):
	var layer = TileMapLayer.new()
	layer.tile_set = load("res://assets/tileset.tres")
	layer.y_sort_enabled = true
	layer.position.y -= index*8
	layer.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	return layer
