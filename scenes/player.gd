extends CharacterBody2D
#setup base,dash and normal speed
@export var b_speed := 800
@export var d_sp := 1300
var speed = b_speed

func _ready() -> void:
	#starting position for the player
	position = Vector2(881,496)
	
func _process(_delta: float) -> void:
	#getting input and moving accordingly
	var direct = Input.get_vector("left","right","up","down")
	velocity = direct * speed
	#dash via dash timer and dash speed
	if Input.is_action_just_pressed("dash") and direct!=Vector2(0,0) and $DashTimer.is_stopped():
		speed = d_sp
		$DashTimer.start()
	move_and_slide()


func _on_dash_timer_timeout() -> void:
	#reseting the speed of the player after dashing
	speed = b_speed
