class_name PlayerRunState
extends PlayerState

func enter(_msg: Dictionary = {}) -> void:
	print("enter run")
	player.ap.play("run")
	
func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
		
	var move_x = player.get_input_x()
		
	player.check_flip(move_x)
	player.velocity.y += player.gravity * delta
		
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Air", {do_jump = true})
	elif move_x == 0:
		state_machine.transition_to("Idle")
	elif player.get_dash_pressed():
		state_machine.transition_to("Dash")
	else:
		var velocity = player.velocity.x + player.accel * move_x * delta
		player.velocity.x = clamp(velocity, -player.speed, player.speed)
		player.move_and_slide()
