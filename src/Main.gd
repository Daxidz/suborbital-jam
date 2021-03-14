extends Node2D

onready var healthbar: TextureProgress = get_node("CanvasLayer2/TextureProgress")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _onPlayerFanageChange(cur_fanage: float, base_fanage: float):
	healthbar.min_value = 0
	healthbar.max_value = base_fanage
	healthbar.value = cur_fanage
	pass
