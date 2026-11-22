extends TabBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_tab_clicked(tab: int) -> void:
	for tabs in get_children():
		tabs.visible = false
	var tab_string= "tab_" + str(tab)
	var show_tab = find_child(tab_string)
	show_tab.visible = true


func _on_texture_button_pressed() -> void:
	pass # Replace with function body.
