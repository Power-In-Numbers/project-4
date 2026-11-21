class_name Card extends Button

@onready var animation: AnimationPlayer = $AnimationPlayer
var tween: Tween
func animate():
	if tween:
		tween.kill()
	tween = create_tween()
	
func _ready() -> void:
	pass

func enlarge() ->void:
	animate()
	tween.tween_property(self, "scale", Vector2(1.5,1.5), 0.5)

func pulse() -> void:
	animate()
	var prev_scale: Vector2 = self.scale
	tween.tween_property(self, "scale", prev_scale + Vector2(0.5,0.5), 0.15)
	tween.tween_property(self, "scale", prev_scale, 0.15)
func _on_mouse_entered() -> void:
	animate()
	enlarge()
	tween.tween_callback(pulse).set_delay(0.25)


func _on_mouse_exited() -> void:
	pass

func _on_pressed_m1() -> void:
	pass # Replace with function body.


func _on_pressed_m2() -> void:
	pass # Replace with function body.
