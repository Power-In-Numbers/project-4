class_name Card extends Button

@onready var animation: AnimationPlayer = $AnimationPlayer
var tween: Tween
var preview_scene: PackedScene = preload("res://scenes/card_preview.tscn")
func animate():
	if tween:
		tween.kill()
	tween = create_tween()

func _ready() -> void:
	pass

func enlarge() ->void:
	animate()
	tween.tween_property(self, "scale", Vector2(2.5,2.5), 0.5)

func shrink() -> void:
	animate()
	tween.tween_property(self, "scale", Vector2(2,2), 0.25)


func pulse() -> void:
	animate()
	var prev_scale: Vector2 = self.scale
	tween.tween_property(self, "scale", prev_scale + Vector2(0.25,0.25), 0.5)
	tween.tween_property(self, "scale", prev_scale, 0.5)
	tween.tween_callback(pulse).set_delay(0)
func _on_mouse_entered() -> void:
	animate()
	enlarge()
	tween.tween_callback(pulse).set_delay(0)


func _on_mouse_exited() -> void:
	shrink()


func _on_pressed_m1() -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		pass


func _on_pressed_m2() -> void:
	if Input.is_action_just_pressed("right_click"):
		## key here is to send the data to the card so they remain the same, or the id of it in order to load the correct details
		var _new_preview = preview_scene.instantiate()
		#get_tree().current_scene.add_child(_new_preview)
		add_sibling(_new_preview)
