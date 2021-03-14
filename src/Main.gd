extends Node2D

onready var healthbar: TextureProgress = get_node("UI/TextureProgress")

var athm_color = [Color(0xffffffff), Color(0xb395c4ff), Color(0x5a2e73ff), Color(0x220533ff)]
var athm_sat = [1.0, 1.0, 0.5, 0.3]
var athm_time = 5
var sat

var lvl_athmosphere: int = 4
var cur_lvl_athmosphere: int = 0
var last_lvl_athmosphere: int = cur_lvl_athmosphere

var in_level: bool = false

func _ready():
	$CanvasModulate.color = athm_color[0]
#	$Music.stream = load(MUSIC_PATH + "main_1.ogg")
	
func update_healthbar(cur_fanage: float, base_fanage: float):
	healthbar.min_value = 0
	healthbar.max_value = base_fanage
	healthbar.value = cur_fanage

func update_athmosphere(cur_fanage: float, base_fanage: float):
	print("Cur_lvl: " + str(cur_lvl_athmosphere))
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
