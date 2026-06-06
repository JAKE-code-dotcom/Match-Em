extends Node2D

@onready var anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("Black_in")
	get_tree().create_timer(3).timeout.connect(black_out)
	
func black_out ():
	anim.play("Black_out")
	get_tree().create_timer(3).timeout.connect(go_to_main_scene)
	
func go_to_main_scene ():
	get_tree().change_scene_to_file("res://scenes/ui.tscn")
