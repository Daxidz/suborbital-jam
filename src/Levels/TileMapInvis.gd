extends TileMap


var _discovered: bool = false

export var hide_again: bool = true
export var hide_time: float = 5.0

func undiscover():
	$Tween.interpolate_property(self, "modulate", Color(1.0, 1.0, 1.0, 1.0), Color(1.0, 1.0, 1.0, 0.0), 2, Tween.TRANS_SINE)
	$Tween.start()
	
func discover():
	if _discovered:
		return
	$Tween.interpolate_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), Color(1.0, 1.0, 1.0, 1.0), 2, Tween.TRANS_SINE)
	
	if hide_again:
		$Timer.one_shot = true
		$Timer.wait_time = hide_time
		$Timer.start()
		
	_discovered = true
	$Tween.start()

func _on_Timer_timeout():
	undiscover()
	_discovered = false
