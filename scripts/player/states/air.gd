class_name PlayerAirState
extends PlayerState

func enter(msg: Dictionary = {}) -> void:
	print("enter air")
	if msg.has("do_jump"):
		_do_jump()
	else:
		player.ap.play("fall")
	
func physics_update(delta: float) -> void:
	player.check_flip(player.input.x)
	
	player.velocity.x = player.speed * player.input.x
	player.velocity.y += player.gravity
	player.move_and_slide()
	
	if player.is_on_floor():
		player.reset_jumps()
		if player.input.x != 0:
			state_machine.transition_to("Run")
			return
		else:
			state_machine.transition_to("Idle")
			return
	elif player.input.jump:
		if player.can_jump():
			_do_jump()
	elif player.input.dash:
			state_machine.transition_to("Dash")
			return
			
	if player.velocity.y > 0:
		if player.is_on_wall() && player.get_wall_normal().x == -player.input.x:
			state_machine.transition_to("Wall")
			return
		else:
			player.ap.play("fall")
			player.velocity.y = min(player.velocity.y, player.max_fall_velocity)

func _do_jump() -> void:
	player.consume_jump()
	player.velocity.y = player.jump_velocity
	player.ap.play("jump")
	
