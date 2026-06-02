extends Area2D
signal correct(shape)
signal incorrect(shape)
var color_number
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass



func _on_body_entered(body: Node2D) -> void:
	var level = get_tree().root.get_child(1)
	if level.player_color ==  color_number :
		correct.emit(self)
	else :
		incorrect.emit(self)
