class_name PlayerWallState
extends PlayerState

var wall_direction = 0
var detatch_th = 100.0
var detatch_timer = 0

func enter(_msg: Dictionary = {}) -> void:
	print("enter wall state")
	wall_direction = player.facing
	player.ap.play("idle")
	detatch_timer = detatch_th
	
func physics_update(delta: float) -> void:
	var move_x = player.input.x
	var move_y = player.input.y
	var is_on_wall = player.is_on_wall()
	
	if not is_on_wall or move_x != wall_direction:
		if detatch_timer > 0:
			detatch_timer -= delta * 1000.0
		else:
			if not player.is_on_floor():
				state_machine.transition_to("Air")
				return
			elif move_x != 0:
				state_machine.transition_to("Run")
				return
			else:
				state_machine.transition_to("Idle")
				return
	
	if player.input.jump:
		state_machine.transition_to("Air", {do_wall_jump = true, direction = -player.facing})
		return
	if player.input.dash:
		player.velocity.x = -wall_direction
		player.check_flip(-wall_direction)
		state_machine.transition_to("Dash")
		return
	

	player.velocity.x = wall_direction
	player.velocity.y += player.gravity
	if player.velocity.y >= 0:
		player.velocity.y = clamp(player.velocity.y, 0, player.wall_slide_speed)

	player.move_and_slide()
		
