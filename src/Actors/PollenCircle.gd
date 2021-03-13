extends Node2D

signal polenize_done

func pollenize(): 
	$AnimationPlayer.play("pollenize")
	
func _ready():
	$AnimationPlayer.connect("animation_finished", self, "_onAnimFinished")


func _onAnimFinished(anim_name):
	if anim_name == "pollenize":
		emit_signal("polenize_done")
		queue_free()


func _on_WallDetectArea_body_entered(body):
	body.discover()
