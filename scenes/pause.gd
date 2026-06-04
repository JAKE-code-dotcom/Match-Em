extends Control

func _ready() -> void:
	$AnimationPlayer.play("RESET")

func pause() : 
	get_tree().paused = true
	$AnimationPlayer.play("new_animation")
	
func resume() : 
	get_tree().paused = false
	$AnimationPlayer.play_backwards("new_animation")
func esc() : 
	if Input.is_action_just_pressed("pause") and get_tree().paused == false : 
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused == true :
		resume()



func _on_resume_pressed() -> void:
	resume()


func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()


func _on_quit_pressed() -> void:
	get_tree().quit()


func _process(delta: float) -> void:
	esc()
