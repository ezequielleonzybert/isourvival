extends PointLight2D

const SPEED = 10
const RANGE = 0.1
var t = 0

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	energy = sin(t*delta)*RANGE + 1 - RANGE
	t += SPEED
