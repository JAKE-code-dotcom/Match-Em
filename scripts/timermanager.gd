extends Node

var time := 5.0

func sub_time (timerr : Timer) : 
	time -= 0.5
	timerr.wait_time = time
func reset_timer (timerr : Timer) :
	time = 5.0
	timerr.wait_time = time
