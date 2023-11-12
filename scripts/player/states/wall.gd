class_name PlayerWallState
extends PlayerState

var wall_direction = 0

func enter(_msg: Dictionary = {}) -> void:
	print("enter wall state")
	wall_direction = player.facing
	player.ap.play("idle")
	
func physics_update(_delta: float) -> void:
	var move_x = player.get_input_x()
	var move_y = player.get_input_y()
	var is_on_wall = player.is_on_wall()
	
	if not is_on_wall or move_x != wall_direction:
		if not player.is_on_floor():
			state_machine.transition_to("Air")
			return
		elif move_x != 0:
			state_machine.transition_to("Run")
			return
		else:
			state_machine.transition_to("Idle")
			return
	else:
		player.velocity.x = wall_direction
	if move_y != 0:
		var speed = -player.wall_climb_speed if move_y < 0 else player.wall_slide_speed
		player.velocity.y = speed
	else:
		player.velocity.y = 0
	player.move_and_slide()
		
