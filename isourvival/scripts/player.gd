extends CharacterBody2D

const FORCE = 150
const DAMPING = .9

var state = "idle"
var acceleration := Vector2.ZERO
var direction := Vector2.ZERO

func _physics_process(delta: float) -> void:
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		state = "walking"
		direction = get_local_mouse_position().normalized()
		acceleration = direction * FORCE
			
	if state == "walking":
		acceleration *= DAMPING
		velocity = acceleration
		if velocity.length_squared() < 1:
			state = "idle"
			acceleration = Vector2.ZERO
			velocity = Vector2.ZERO
		
	move_and_slide()
