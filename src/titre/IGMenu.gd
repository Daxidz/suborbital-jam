extends Control

var activated: bool = false

func _ready():
	pass

func activate():
#	get_tree().paused = true
	visible = true
	$QUIT.disabled = false
	$RESUME.disabled = false
	activated = true
	
func deactivate():
	
	get_tree().paused = false
	visible = false
	$QUIT.disabled = true
	$RESUME.disabled = true
	activated = false

func _on_TextureButton_pressed():
	deactivate()
	


func _on_TextureButton2_pressed():
	get_tree().quit()
