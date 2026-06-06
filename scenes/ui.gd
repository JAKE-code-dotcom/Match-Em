extends Node2D

#start button goes to level scene
func _on_start_butt_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level.tscn")


#quit button shuts down the game
func _on_quit_butt_pressed() -> void:
	get_tree().quit()


func _on_controls_butt_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/controls.tscn")
