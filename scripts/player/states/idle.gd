class_name PlayerIdleState
extends PlayerState

func enter(_msg: Dictionary = {}) -> void:
	print("enter idle state")
	player.ap.play("idle")
	player.reset_jumps()
	
func physics_update(delta: float):
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
		
	if player.input.jump:
		state_machine.transition_to("Air", {
			do_jump = true
		})
		return
	elif player.input.dash:
		state_machine.transition_to("Dash")
		return
		
	if player.input.x != 0:
		state_machine.transition_to("Run")
	elif player.velocity.x != 0:
		var velocity = player.velocity.x + -player.facing * player.decel * delta
		player.velocity.x = 0.0 if sign(velocity) != sign(player.velocity.x) else velocity
		player.move_and_slide()
