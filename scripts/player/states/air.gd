class_name PlayerAirState
extends PlayerState

func enter(msg: Dictionary = {}) -> void:
	print("enter air")
	if msg.has("do_jump"):
		_do_jump()
	else:
		player.ap.play("fall")
	
func physics_update(delta: float) -> void:
	var move_x = player.get_input_x()
	
	player.check_flip(move_x)
	
	player.velocity.x = player.speed * move_x
	player.velocity.y += player.gravity
	player.move_and_slide()
	
	if player.is_on_floor():
		player.reset_jumps()
		if move_x != 0:
			state_machine.transition_to("Run")
			return
		else:
			state_machine.transition_to("Idle")
			return
	elif Input.is_action_just_pressed("ui_accept"):
		if player.can_jump():
			_do_jump()
	elif player.get_dash_pressed():
			state_machine.transition_to("Dash")
			return
			
	if player.velocity.y > 0:
		if player.is_on_wall() && player.get_wall_normal().x == -move_x:
			state_machine.transition_to("Wall")
			return
		else:
			player.ap.play("fall")
			player.velocity.y = min(player.velocity.y, player.max_fall_velocity)

func _do_jump() -> void:
	player.consume_jump()
	player.velocity.y = player.jump_velocity
	player.ap.play("jump")
	
