extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func spawn_player():
	$Player.position = $Position2D.position
	$Player.respawn()

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_player()


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		spawn_player()
