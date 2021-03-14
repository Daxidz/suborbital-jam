extends Control

var current_button_idx
var nb_buttons
var credits_showed = false

export(String, FILE, "*.tscn") var first_room

func _ready():
	nb_buttons = $Buttons.get_child_count()
	current_button_idx = 0
	get_node("/root/Main/Music").play_theme(0)


func hover_button(btn_idx):
	var btn = $Buttons.get_child(btn_idx)
	btn.grab_focus()


func show_credit(show):
	print("CREDITS showed " + str(show))
	$Credits.visible = show
	credits_showed = show

func deactivate():
	visible = false
	for b in $Buttons.get_children():
		b.disabled = true
		
func activate():
	visible = true
	for b in $Buttons.get_children():
		b.disabled = false
	
func _on_Start_pressed():
	print("DEDEED")
	SceneChanger.goto_scene(first_room)
	
	
func _on_QUIT_pressed():
	get_tree().quit()


func _on_START_pressed():
	deactivate()
	SceneChanger.goto_scene(first_room)


func _on_CREDIT_pressed():
	return
	if credits_showed:
		show_credit(false)
	else:
		show_credit(true)
