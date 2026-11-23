extends CanvasLayer

signal loading_screen_ready

@export var animation_player: AnimationPlayer

func _ready() -> void:
	await animation_player.animation_finished
	loading_screen_ready.emit()

func play_animation() -> void:
	animation_player.play("trans")
	await animation_player.animation_finished

func _on_progress_changed(_new_value: float) -> void:
	print(_new_value)
	if _new_value > $progress.value:
		$progress.value = _new_value

func _on_load_finished() -> void:
	animation_player.play_backwards("trans")
	await animation_player.animation_finished
	queue_free()
