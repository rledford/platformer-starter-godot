class_name PlayerIdleState
extends PlayerState

func enter(_msg: Dictionary = {}) -> void:
	print("enter idle")
	player.ap.play("idle")
	
func physics_update(delta: float):
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
		
	var move_x = player.get_input_x()
		
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Air", {
			do_jump = true
		})
		return
	elif player.get_dash_pressed():
		state_machine.transition_to("Dash")
		return
		
	if move_x != 0:
		state_machine.transition_to("Run")
	elif player.velocity.x != 0:
		var velocity = player.velocity.x + -player.facing * player.decel * delta
		player.velocity.x = 0 if sign(velocity) != sign(player.velocity.x) else velocity
		player.move_and_slide()
