extends Node

var lives = 3

func remove_lives():
	lives = lives - 1
	if lives < 0:
		print("you died bum")
