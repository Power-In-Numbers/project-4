extends Control

func _on_host_press() -> void:
	NetworkHandler.start_server()

func _on_button_2_pressed() -> void:
	NetworkHandler.start_client()


func _on_button_3_pressed() -> void:
	if multiplayer.is_server():
		print_once_per_client.rpc()

@rpc
func print_once_per_client():
	print("I will be printed to the console once per each connected client.")
	$msg.text = "we  have printed"


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_deckview_pressed() -> void:
	pass # Replace with function body.


func _on_join_pressed() -> void:
	pass # Replace with function body.


func _on_cardview_pressed() -> void:
	pass # Replace with function body.


func _on_gacha_pressed() -> void:
	pass # Replace with function body.
