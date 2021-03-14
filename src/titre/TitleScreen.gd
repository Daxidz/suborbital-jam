extends Control

var current_button_idx
var nb_buttons
var credits_showed = false

export(String, FILE, "*.tscn") var first_room

func _ready():
	$Credits.visible = false
	nb_buttons = $Buttons.get_child_count()
	current_button_idx = 0
	hover_button(current_button_idx)
	$Buttons/START.connect("pressed", self, "_on_Start_pressed")
	$Buttons/QUIT.connect("pressed", self, "_on_Quit_pressed")
	$Buttons/CREDITS.connect("pressed", self, "_on_Credits_pressed")


func hover_button(btn_idx):
	var btn = $Buttons.get_child(btn_idx)
	btn.grab_focus()
	btn.hovering()


func show_credit(show):
	print("CREDITS showed " + str(show))
	$Credits.visible = show
	credits_showed = show

func _process(delta):
	if not credits_showed:
		if Input.is_action_just_pressed("ui_left"):
			$Buttons.get_child(current_button_idx).exit_hover()
			if current_button_idx == 0:
				current_button_idx = nb_buttons-1
			else:
				current_button_idx = (current_button_idx - 1) % nb_buttons
				
			hover_button(current_button_idx)
		if Input.is_action_just_pressed("ui_right"):
			$Buttons.get_child(current_button_idx).exit_hover()
			current_button_idx = (current_button_idx + 1) % nb_buttons
			hover_button(current_button_idx)
		
func _on_Start_pressed():
	SceneChanger.goto_scene(first_room)
	get_tree().root.get_node("Main").remove_title_screen()
	
func _on_Quit_pressed():
	get_tree().quit()
	
func _on_Credits_pressed():
	if credits_showed:
		show_credit(false)
	else:
		show_credit(true)
