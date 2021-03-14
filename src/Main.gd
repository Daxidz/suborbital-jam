extends Node2D

onready var healthbar: TextureProgress = get_node("UI/HB/TextureProgress")

var athm_color = [Color(0xffffffff), Color(0xb395c4ff), Color(0x5a2e73ff), Color(0x220533ff)]
var athm_sat = [1.0, 1.0, 0.7, 0.5]
var athm_time = 5
var sat

var lvl_athmosphere: int = 4
var cur_lvl_athmosphere: int = 3
var last_lvl_athmosphere: int = cur_lvl_athmosphere

var in_level: bool = false

func _ready():
	$CanvasModulate.color = athm_color[0]
	$UI/CanvasLayer/Menu.connect("game_started", self, "onGameStarted")
	$UI/CanvasLayer/IGMenu.deactivate()
	$UI/HB/TextureProgress.visible = false
	show_menu()
	
func update_healthbar(cur_fanage: float, base_fanage: float):
	healthbar.min_value = 0
	healthbar.max_value = base_fanage
	healthbar.value = cur_fanage

func update_athmosphere(cur_fanage: float, base_fanage: float):
	if cur_fanage == 0.0:
		cur_lvl_athmosphere = 3
	else:
		cur_lvl_athmosphere = int(cur_fanage *3 / base_fanage)
	
	if (last_lvl_athmosphere != cur_lvl_athmosphere):
		$CanvasModulate/Tween.interpolate_property($CanvasModulate, "color", athm_color[3-last_lvl_athmosphere], athm_color[3-cur_lvl_athmosphere], athm_time, Tween.TRANS_SINE)
		$CanvasModulate/Tween.interpolate_property($WorldEnvironment.environment, "adjustment_saturation", athm_sat[3-last_lvl_athmosphere], athm_sat[3-cur_lvl_athmosphere], athm_time, Tween.TRANS_SINE)
		$CanvasModulate/Tween.start()
	last_lvl_athmosphere = cur_lvl_athmosphere

func _onPlayerFanageChange(cur_fanage: float, base_fanage: float):
	update_healthbar(cur_fanage, base_fanage)
	update_athmosphere(cur_fanage, base_fanage)
	
	
func show_menu():
	$UI/CanvasLayer/Menu.activate()
	
func hide_menu():
	$UI/CanvasLayer/Menu.deactivate()

func onGameStarted():
	$UI/HB/TextureProgress.visible = true
	in_level = true
	
func onPlayerDeath():
	$UI/CanvasLayer/IGMenu.activate()
	
func onPlayerRespawn():
	$UI/CanvasLayer/IGMenu.deactivate()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if in_level:
			if $UI/CanvasLayer/IGMenu.activated:
				$UI/CanvasLayer/IGMenu.deactivate()
			else:
				$UI/CanvasLayer/IGMenu.activate()
