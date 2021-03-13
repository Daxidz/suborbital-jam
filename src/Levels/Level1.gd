extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.position = $Position2D.position


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$Player.position = $Position2D.position
