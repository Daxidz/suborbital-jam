extends Area2D


export(String, FILE, "*.tscn") var next_room




func _ready():
	pass


func _on_LevelEnd_body_entered(body):
	SceneChanger.goto_scene(next_room)
