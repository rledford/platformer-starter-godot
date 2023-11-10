class_name PlayerDashState
extends PlayerState

var timer = 0

func enter(_msg: Dictionary = {}):
	print("enter dash")
	timer = player.dash_time
	
func physics_update(delta: float) -> void:
	timer -= delta * 1000.0
	if timer < 0:
		if player.is_on_floor():
			if player.get_input_x() != 0:
				state_machine.transition_to("Run")
			else:
				state_machine.transition_to("Idle")
				
		else:
			state_machine.transition_to("Air")
	else:
		player.velocity.x = player.facing * player.dash_speed
		player.move_and_slide()
		
	
