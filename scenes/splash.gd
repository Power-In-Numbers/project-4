extends BaseScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SceneHandler.load_next_scene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
