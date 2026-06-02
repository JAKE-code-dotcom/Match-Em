extends Node

var score = 0

func add_points(points: int):
	score += points
	print("Score: ", score)

func reset_score():
	score = 0
