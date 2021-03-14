extends Area2D

signal game_end

func _ready():
	connect("game_end", get_node("/root/Main/"), "onGameEnd")
	pass

func _on_LOVER_body_entered(body):
	emit_signal("game_end")
