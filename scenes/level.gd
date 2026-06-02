extends Node2D
#random number generator for random position for shapes and player color
var rng := RandomNumberGenerator.new()
var t : PackedScene = load("res://scenes/triangle.tscn")
var c : PackedScene = load("res://scenes/circle.tscn")
var s : PackedScene = load("res://scenes/square.tscn")
var player_color := 4
var can_coll := false
var collected := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player/PlayerImage.texture = load("res://Player/P4.png")
	$StartTimer.start()
	$ScoreRect/Sc.text = "Score : "+str(ScoreManager.score)

func _process(_delta: float) -> void:
	$TimeRect/Time.text = "%02d:%02d" % time_lf()

#the shape spawning function (ran if the level timer did not end and the player collected its colors)
func set_up():
	var width = get_viewport().get_visible_rect().size[0]
	var height = get_viewport().get_visible_rect().size[1]
	for i in range(1,4) :
		#triangle
		var tr = t.instantiate()
		tr.get_child(0).texture = load("triangles/T"+str(i)+".png")
		$shapes.add_child(tr)
		
		tr.position = get_random_spawn_pos(width,height)
		
		tr.color_number = i
		tr.correct.connect(_on_correct)
		tr.incorrect.connect(_on_incorrect)
		#circle
		var cr = c.instantiate()
		cr.get_child(0).texture = load("circles/C"+str(i)+".png")
		$shapes.add_child(cr)
		cr.position = get_random_spawn_pos(width,height)
		
		
		cr.color_number = i
		cr.correct.connect(_on_correct)
		cr.incorrect.connect(_on_incorrect)
		
		#square
		var sr = s.instantiate()
		sr.get_child(0).texture = load("squares/S"+str(i)+".png")
		$shapes.add_child(sr)
		
		sr.position = get_random_spawn_pos(width,height)
		sr.color_number = i
		sr.correct.connect(_on_correct)
		sr.incorrect.connect(_on_incorrect)
		

func get_random_spawn_pos(width , height) -> Vector2 :
	var pos = Vector2(
		rng.randi_range(0,width),
		rng.randi_range(0,height)
		)
	return pos

func _on_timer_timeout() -> void:
	set_up()
	var ff = rng.randi_range(1,3)
	$Player/PlayerImage.texture = load("res://Player/P"+str(ff)+".png")
	player_color = ff
	$LevelTimer.start()
	
	await(get_tree().create_timer(1.0).timeout)
	can_coll = true
func _on_correct (shape) :
	if can_coll : 
		collected+=1
		shape.queue_free()
	if collected == 3 :
		ScoreManager.add_points(1)
		get_tree().reload_current_scene()
	
func _on_incorrect(shape):
	if can_coll == true :
		ScoreManager.reset_score()
		get_tree().change_scene_to_file("res://scenes/retry.tscn")
		


func _on_level_timer_timeout() -> void:
	if collected < 3 :
		ScoreManager.reset_score()
		get_tree().change_scene_to_file("res://scenes/retry.tscn")
	
func time_lf () : 
	var time_left = $LevelTimer.time_left
	var minute = floor(time_left /60)
	var second = int (time_left) %60
	return[minute , second]
