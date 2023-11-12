class_name Player
extends CharacterBody2D

class PlayerInput:
	var x: int
	var y: int
	var dash: bool
	var jump: bool
	var jump_canceled: bool

@export var gravity := 30.0
@export var speed := 150.0
@export var accel := 9000.0
@export var decel := 9000.0
@export var air_accel := 750.0
@export var air_decel := 750.0
@export var jump_velocity := -600.0
@export var jump_cancel_mult := 0.25
@export var jump_buffer_time := 100.0
@export var max_jumps := 2
@export var max_fall_velocity := 600.0
@export var dash_time := 200.0
@export var dash_speed := 300.0
@export var wall_slide_speed := 75.0
@export var coyote_time := 100.0
@export var _coyote_timer := 0.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var input = PlayerInput.new()

var facing: int = 1
var _jumps_remaining: int = max_jumps
var _jump_buffer_timer: float = 0.0
	
func _gather_input() -> void:
	
	input.x = Input.get_axis("move_left", "move_right")
	input.y = Input.get_axis("move_up", "move_down")
	input.jump = _jump_buffer_timer > 0
	input.jump_canceled = Input.is_action_just_released("ui_accept")
	input.dash = Input.is_action_just_pressed("dash")
	
func _physics_process(delta) -> void:
	if _jump_buffer_timer > 0:
		_jump_buffer_timer -= delta * 1000.0
	if _coyote_timer > 0:
		_coyote_timer -= delta * 1000.0
		
	if Input.is_action_just_pressed("ui_accept"):
		_jump_buffer_timer = jump_buffer_time
	
	_gather_input()
	
func check_flip(direction: int) -> void:
	if direction == 0: return
	
	var new_facing = sign(direction)
	
	if facing != new_facing:
		facing = new_facing
		scale.x *= -1
		
func consume_jump() -> void:
	_jump_buffer_timer = 0
	_jumps_remaining -= 1
	_coyote_timer = 0
	
func consume_wall_jump() -> void:
	_jump_buffer_timer = 0
	
func can_jump() -> bool:
	return _jumps_remaining > 0
	
func reset_jumps() -> void:
	_jumps_remaining = max_jumps
	
func start_coyote() -> void:
	print("start coyote time")
	_coyote_timer = coyote_time
	
func has_coyote() -> bool:
	return _coyote_timer > 0
