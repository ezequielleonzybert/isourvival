extends Node2D

const MAX_HEIGHT = 4
const WORLD_SIZE = 20

func _ready() -> void:
	
	var layers = []
	
	for i in range(MAX_HEIGHT):
		var layer = TileMapLayer.new()
		layer.tile_set = load("res://assets/tileset.tres")
		layer.y_sort_enabled = true
		layer.position.y += i*8
		for x in range (-WORLD_SIZE/(2+i*2), WORLD_SIZE/(2+i*2)):
			for y in range (-WORLD_SIZE/(1+i*2), WORLD_SIZE/(1+i*2)):
				layer.set_cell(Vector2(x,y),0,Vector2(1,0))
		
		add_child(layer)
