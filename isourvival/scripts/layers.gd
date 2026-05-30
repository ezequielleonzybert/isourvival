extends Node2D

const MAX_HEIGHT = 8
const WIDTH = 100
const HEIGHT = 200

enum Type {WATER, MUD, GRASS, SNOW}

class Tile:
	var position : Vector2
	var type_coords : Vector2
	var top : bool = false
	var air : bool = false
	
	func _init(_position):
		position = _position
	
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

var layersData = []

func _ready() -> void:
	layersData.resize(MAX_HEIGHT)
	
	var noise = makeNoise(0.007)
	
	for i in range(MAX_HEIGHT-1, -1, -1):
		var layerData = []
		var visibleLayer = makeLayer(i)
		
		for y in range (HEIGHT):
			for x in range (WIDTH):
				
				var index = x+y*WIDTH
				var value = (noise.get_noise_2d(x*2,y) + 1.0) / 2.0 * MAX_HEIGHT
				var tile = Tile.new(Vector2(x,y))
				tile.set_type_coords(Type.MUD)
				
				if value > i:
					if i == MAX_HEIGHT-1:
						tile.top = true
					
					elif layersData[i+1][index].air == true:
						tile.top = true
					
				else:
					tile.air = true
				
				if tile.top:
					visibleLayer.set_cell(tile.position,0,tile.type_coords)
				
				layerData.append(tile)
		
		layersData[i] = layerData
		add_child(visibleLayer)

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
	layer.position.y += index*8
	layer.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	return layer
