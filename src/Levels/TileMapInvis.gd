extends TileMap


var _discovered: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func discover():
	if _discovered:
		return
	$Tween.interpolate_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), Color(1.0, 1.0, 1.0, 1.0), 2, Tween.TRANS_SINE)
	$Tween.start()
	_discovered = true
