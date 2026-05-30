extends Camera2D

const FORCE = 10
const DAMPING = .05

var velocity := Vector2.ZERO

func _process(delta: float) -> void:
	var direction = Vector2.ZERO
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	var acceleration = direction.normalized() * FORCE
	
	velocity += acceleration * delta
	velocity *= pow(DAMPING, delta)
	position += velocity
	
	if Input.is_action_just_pressed("zoom_in"):
		zoom += Vector2(.5,.5)
	elif Input.is_action_just_pressed("zoom_out"):
		zoom -= Vector2(.5,.5)
