extends Node2D

signal polenize_done

func pollenize(): 
	$AnimationPlayer.play("pollenize")
	
func _ready():
	$AnimationPlayer.connect("animation_finished", self, "_onAnimFinished")


func _onAnimFinished(anim_name):
	if anim_name == "pollenize":
		print("POLENIZE DONE")
		emit_signal("polenize_done")


func _on_WallDetectArea_area_entered(area):
	pass # Replace with function body.


func _on_WallDetectArea_body_entered(body):
	print(body)
	body.visible = true
