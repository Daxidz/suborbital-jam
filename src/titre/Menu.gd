extends Control

var current_button_idx
var nb_buttons
var credits_showed = false

signal game_started

export(String, FILE, "*.tscn") var first_room

func _ready():
	nb_buttons = $Buttons.get_child_count()
	current_button_idx = 0
	get_node("/root/Main/Music").play_theme(0)
	show_credit(false)


func hover_button(btn_idx):
	var btn = $Buttons.get_child(btn_idx)
	btn.grab_focus()

func _input(event):
	if event.is_action_pressed("ui_cancel") and credits_showed:
		show_credit(false) 

func show_credit(show):
	$CREDITS.visible = show
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
	emit_signal("game_started")


func _on_CREDIT_pressed():
	if credits_showed:
		show_credit(false)
	else:
		show_credit(true)
