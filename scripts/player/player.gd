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
@export var air_decel := 1000.0
@export var jump_velocity := -600.0
@export var max_jumps := 3
@export var max_fall_velocity := 600.0
@export var dash_time := 200.0
@export var dash_speed := 300.0
@export var wall_climb_speed := 100.0
@export var wall_slide_speed := 75.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var input = PlayerInput.new()

var facing: int = 1
var _jumps_remaining: int = max_jumps
	
func _gather_input() -> void:
	input.x = Input.get_axis("move_left", "move_right")
	input.y = Input.get_axis("move_up", "move_down")
	input.jump = Input.is_action_just_pressed("ui_accept")
	input.jump_canceled = Input.is_action_just_released("ui_accept")
	input.dash = Input.is_action_just_pressed("dash")
	
func _physics_process(_delta) -> void:
	_gather_input()
	
func check_flip(direction: int) -> void:
	if direction == 0: return
	
	var new_facing = sign(direction)
	
	if facing != new_facing:
		facing = new_facing
		scale.x *= -1
		
func consume_jump() -> void:
	_jumps_remaining -= 1
	
func can_jump() -> bool:
	return _jumps_remaining > 0
	
func reset_jumps() -> void:
	_jumps_remaining = max_jumps
