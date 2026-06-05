extends Label

func _process(delta: float) -> void:
	text = "FPS: " + str(int(Engine.get_frames_per_second()))
