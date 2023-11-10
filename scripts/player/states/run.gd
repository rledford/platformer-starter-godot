class_name PlayerRunState
extends PlayerState

func enter(_msg: Dictionary = {}) -> void:
	print("enter run")
	
func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
		
	var move_x = player.get_input_x()
	
	player.velocity.x = player.speed * move_x
	player.velocity.y += player.gravity * delta
	
	if player.is_on_wall():
		state_machine.transition_to("Wall")
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Air", {do_jump = true})
	elif move_x == 0 and is_equal_approx(player.velocity.x, 0.0):
		state_machine.transition_to("Idle")
	elif player.get_dash_pressed():
		state_machine.transition_to("Dash")
	else:
		player.move_and_slide()
