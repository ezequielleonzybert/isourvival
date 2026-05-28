extends CharacterBody2D

@onready var sound_step: AudioStreamPlayer = $sound_step

const FORCE = 100
const DAMPING = .9

var state = "idle"
var acceleration := Vector2.ZERO
var direction := Vector2.ZERO
var distance_counter := 0

func _physics_process(delta: float) -> void:
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		state = "walking"
		direction = get_local_mouse_position().normalized()
		acceleration = direction * FORCE
			
	if state == "walking":
		acceleration *= DAMPING
		velocity = acceleration
		stepSound(delta)
		if velocity.length_squared() < 1:
			state = "idle"
			acceleration = Vector2.ZERO
			velocity = Vector2.ZERO
		
	move_and_slide()
	
func stepSound(delta):
	distance_counter += abs(velocity.length_squared()*delta/100)
	distance_counter = distance_counter % 150
	if distance_counter % 15 == 1:
		sound_step.pitch_scale = randf_range(0.8,1.2)
		sound_step.play(0)
