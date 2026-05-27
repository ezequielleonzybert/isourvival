extends Node2D

const FORCE = 30
const DAMPING = .95

var camera
var velocity := Vector2.ZERO

func _ready() -> void:
	camera = $Camera2D

func _process(delta: float) -> void:
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	var acceleration = direction.normalized() * FORCE
	
	velocity += acceleration * delta
	velocity *= DAMPING
	camera.position += velocity
