class_name PlayerAirState
extends PlayerState

func enter(msg: Dictionary = {}) -> void:
	print("enter air")
	if msg.has("do_jump"):
		player.velocity.y = player.jump_velocity
	
func physics_update(delta: float) -> void:
	var move_x = player.get_input_x()
	
	player.velocity.x = player.speed * move_x
	player.velocity.y += player.gravity
	player.move_and_slide()
	
	if player.is_on_floor():
		if move_x != 0:
			state_machine.transition_to("Run")
		else:
			state_machine.transition_to("Idle")
	elif player.get_dash_pressed():
			state_machine.transition_to("Dash")
		
	
	
