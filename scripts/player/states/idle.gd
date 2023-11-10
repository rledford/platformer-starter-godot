class_name PlayerIdleState
extends PlayerState

func enter(_msg: Dictionary = {}) -> void:
	print("enter idle")
	player.velocity = Vector2.ZERO
	
func physics_update(_delta: float):
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
		
	var move_x = player.get_input_x()
		
	if Input.is_action_just_pressed("ui_accept"):
		state_machine.transition_to("Air", {
			do_jump = true
		})
	elif move_x != 0:
		state_machine.transition_to("Run")
	elif player.get_dash_pressed():
		state_machine.transition_to("Dash")
