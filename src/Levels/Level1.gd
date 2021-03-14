extends Node2D


func spawn_player():
	$Player.position = $Position2D.position
	$Player.respawn()

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_player()


func _input(event):
	if event.is_action_pressed("respawn"):
		spawn_player()
