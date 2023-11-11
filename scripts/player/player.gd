class_name Player
extends CharacterBody2D

@export var gravity = 30
@export var speed = 200
@export var jump_velocity = -500
@export var max_fall_velocity = 1000
@export var dash_time = 150
@export var dash_speed = 300
@export var wall_climb_speed = 100
@export var wall_slide_speed = 75

@onready var sprite = $Sprite2D

var facing: int = 1

func get_input_x() -> int:
	return Input.get_axis("move_left", "move_right")
	
func get_input_y() -> int:
	return Input.get_axis("move_up", "move_down")
	
func get_dash_pressed() -> bool:
	return Input.is_action_just_pressed("dash")
	
func _process(_delta: float) -> void:
	var was_facing = facing
	facing = facing if velocity.x == 0 else sign(velocity.x)
	if was_facing != facing:
		scale.x = scale.x * -1
