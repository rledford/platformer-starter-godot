class_name Player
extends CharacterBody2D

#enum States {
#	Normal = 0,
#	Climb = 1,
#	Dash = 2
#}
#
#class Inputs:	
#	var move_x: int = 0
#	var move_y: int = 0
#	var jump: bool = false
#	var jump_canceled: bool = false
#
@export var gravity = 30
@export var speed = 200
@export var jump_velocity = -500
@export var max_fall_velocity = 1000
@export var dash_time = 150
@export var dash_speed = 300
@export var wall_climb_speed = 100
@export var wall_slide_speed = 75

var facing: int = 1

func get_input_x() -> int:
	return Input.get_axis("move_left", "move_right")
	
func get_input_y() -> int:
	return Input.get_axis("move_up", "move_down")
	
func get_dash_pressed() -> bool:
	return Input.is_action_just_pressed("dash")
	
func _process(_delta: float) -> void:
	facing = facing if velocity.x == 0 else sign(velocity.x)
	
	
#
#@onready var ap = $AnimationPlayer
#@onready var sprite = $Sprite2D
#
#var stat: States = States.Normal
#var facing: int = 1
#var inputs: Inputs = Inputs.new()
#
#func _physics_process(delta):
#	if !is_on_floor():
#		apply_gravity()
#
#	if inputs.jump and is_on_floor():
#		velocity.y = jump_velocity
#
#	if inputs.move_x != 0:
#		velocity.x = inputs.move_x * speed
#	else:
#		velocity.x = move_toward(velocity.x, 0, speed)
#
#	move_and_slide()
#
#func _process(_delta):
#	gather_input()
#	update_facing()
#	update_animation()
#
#func switch_direction(direction):
#	sprite.flip_h = (direction == -1)
#	sprite.position.x = direction * 4
#
#func gather_input():
#	inputs.move_x = Input.get_axis("move_left", "move_right")
#	inputs.move_y = 0 # change to get axis "move_up", "move_down" for wall climb
#	inputs.jump = Input.is_action_just_pressed("ui_accept")
#	inputs.jump_canceled = Input.is_action_just_released("ui_accept")
#
#func apply_gravity():
#	if velocity.y < 0 and velocity.y < jump_velocity * 0.5 and inputs.jump_canceled:
#		velocity.y += gravity * 7
#
#	velocity.y += gravity
#	velocity.y = min(max_fall_velocity, velocity.y)
#
#func update_facing():
#	if inputs.move_x != 0:
#		facing = inputs.move_x
#		sprite.flip_h = facing != 1
#
#func update_animation():
#	if is_on_floor():
#		if inputs.move_x:
#			ap.play("run")
#		else:
#			ap.play("idle")
#	else:
#		if velocity.y > 0:
#			#fall
#			ap.play("fall")
#		elif velocity.y < 0:
#			#jump
#			ap.play("jump")
