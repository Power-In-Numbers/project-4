extends AnimatedSprite2D
signal pack_ripped
signal pack_gone
var current_string
var current_index

func _get_proper_sprite_animation(_string = "generic", index: int = 1) -> String:
	current_string = _string
	current_index = index
	return "pack_" + _string + "_" + index
	
func _rip_pack() -> void:
	self.play(_get_proper_sprite_animation(_get_proper_sprite_animation(current_string, current_index)))
	await self.animation_finished
	pack_ripped.emit()

func _on_pack_ripped() ->void:
	$RichTextLabel.visible = false
	$AnimationPlayer.play("move_down_and_fade")
	await $AnimationPlayer.animation_finished
	pack_gone.emit
	queue_free()
