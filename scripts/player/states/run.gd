class_name PlayerRunState
extends PlayerState

func enter(_msg: Dictionary = {}) -> void:
	print("enter run")
	player.ap.play("run")
	
func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
		
	player.check_flip(player.input.x)
	player.velocity.y += player.gravity * delta
		
	if player.input.jump:
		state_machine.transition_to("Air", {do_jump = true})
		return
	elif player.input.x == 0:
		state_machine.transition_to("Idle")
		return
		
	if player.input.dash:
		state_machine.transition_to("Dash")
	else:
		var velocity = player.velocity.x + player.accel * player.input.x * delta
		player.velocity.x = clamp(velocity, -player.speed, player.speed)
		player.move_and_slide()
