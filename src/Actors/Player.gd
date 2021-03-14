extends Actor

signal fanage_changed(cur_fanage, base_fanage)
signal death
signal respanwned

var state_machine

export var stomp_impulse: = 600.0
export var fanage_base: float = 10000
export var coyote_time_time = 0.5;

export var pollen_cost: int = 100

var _pollenizing: bool = false

var coyote_time: Timer
var is_jumping: bool = false

var _fanage_restant: float = fanage_base
var _dead: bool = false

const PollenCircle = preload("res://src/Actors/PollenCircle.tscn")

func respawn():
	_dead = false
	modulate = Color(1,1,1,1)
	$Camera2D.current = true
	
	_velocity = Vector2.ZERO
	set_fanage(fanage_base)
	set_physics_process(true)
	set_process(true)
	emit_signal("respanwned")

func pollenize():
	if _pollenizing:
		return
		
	_pollenizing = true
	set_fanage(_fanage_restant - pollen_cost)
	var pc = PollenCircle.instance()
	pc.connect("polenize_done", self, "_onPollenizeDone")
	pc.position = $Position2D.global_position
	get_parent().add_child(pc)
	pc.pollenize()
	

func _ready():
	coyote_time = Timer.new()
	coyote_time.one_shot = true
	coyote_time.wait_time = coyote_time_time
	add_child(coyote_time)
	state_machine = $AnimationTree.get("parameters/playback")
	connect("fanage_changed", get_node("/root/Main"), "_onPlayerFanageChange")
	connect("death", get_node("/root/Main"), "onPlayerDeath")
	connect("respanwned", get_node("/root/Main"), "onPlayerRespawn")
	state_machine.start("idle")

func _input(event):
	if event.is_action_pressed("pollenize"):
			pollenize()


func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	die()

func _physics_process(delta: float) -> void:
	
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	var snap: Vector2 = Vector2.DOWN * 60.0 if direction.y == 0.0 else Vector2.ZERO
	
	if is_on_floor():
		coyote_time.stop()
		is_jumping = false
		if Input.is_action_just_pressed("jump"):
			is_jumping = true
	
	var was_on_floor = is_on_floor()
	
	_velocity = move_and_slide_with_snap(
		_velocity, snap, FLOOR_NORMAL, true
	)
	
	if not is_on_floor()  and was_on_floor and not is_jumping:
		coyote_time.start()
		_velocity.y = 0
	
	if not _velocity.y > 0.0:
		set_fanage(_fanage_restant - delta * _velocity.length())


func _process(delta):
	if is_on_floor():
		if (_velocity.x == 0.0):
			state_machine.travel("idle")
		else:
			state_machine.travel("walk")
	else:
		if _velocity.y > 0.0:
			print("FALL")
			state_machine.travel("fall")
		else:
			print("JMP")
			state_machine.travel("jump")
	if _velocity.x > 0:
			$Sprite.flip_h = false
	elif _velocity.x < 0:
			$Sprite.flip_h = true
			

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-Input.get_action_strength("jump") if (is_on_floor() or not coyote_time.is_stopped()) and Input.is_action_just_pressed("jump") else 0.0
	)
	


func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var velocity: = linear_velocity
	
	velocity.x = speed.x * direction.x
			
	if direction.y != 0.0:
		velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		velocity.y = 0.0
		
	if velocity.length() > 10000 and not _dead:
		print("DEAD")
		die()
	return velocity


func die() -> void:
	if _dead:
		return
	_dead = true
#	modulate = Color.red
	state_machine.travel("die")
	set_physics_process(false)
	set_process(false)
	emit_signal("death")
	
func set_fanage(new_fanage: float):
	
	_fanage_restant = new_fanage
	if _fanage_restant < 0.0:
		_fanage_restant = 0.0

	if _fanage_restant <= 0:
		die()
		print("DEAD")

		
	emit_signal("fanage_changed", _fanage_restant, fanage_base)
	pass
	

func _onPollenizeDone():
	_pollenizing = false
