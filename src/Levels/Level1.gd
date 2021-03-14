extends Node2D


var rng = RandomNumberGenerator.new()

func spawn_player():
	$Player.position = $Position2D.position
	$Player.respawn()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var theme: int = rng.randi_range(1,2);
	get_node("/root/Main/Music").play_theme(theme)
	spawn_player()


func _input(event):
	if event.is_action_pressed("respawn"):
		spawn_player()
