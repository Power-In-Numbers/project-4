extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity  = direction * SPEED

	move_and_slide()
