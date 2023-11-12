class_name PlayerAirState
extends PlayerState

var is_wall_jumping: bool = false
var wall_jump_input_th: float = 150.0
var wall_jump_input_timer: float = 0.0

func enter(msg: Dictionary = {}) -> void:
	print("enter air")
	if msg.has("do_wall_jump"):
		_do_wall_jump(msg.get("direction"))
	elif msg.has("do_jump"):
		_do_jump()
	else:
		player.ap.play("fall")

func update(delta):
	if is_wall_jumping:
		wall_jump_input_timer -= delta * 1000.0
		if wall_jump_input_timer <= 0.0:
			print("done wall jumping")
			is_wall_jumping = false
	
func physics_update(delta: float) -> void:
	
	if not is_wall_jumping:
		player.check_flip(player.input.x)
		var velocity = player.velocity.x + player.air_accel * player.input.x * delta
		player.velocity.x = clamp(velocity, -player.speed, player.speed)
		
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
			
	if not is_wall_jumping && player.is_on_wall() && player.get_wall_normal().x == -player.input.x:
		state_machine.transition_to("Wall")
		return
	else:
		player.ap.play("fall")
		player.velocity.y = min(player.velocity.y, player.max_fall_velocity)

func _do_jump() -> void:
	print("do regular jump")
	player.consume_jump()
	player.velocity.y = player.jump_velocity
	player.ap.play("jump")
	
func _do_wall_jump(direction: int) -> void:
	print("do wall jump")
	player.velocity.x = sign(direction) * player.speed
	player.velocity.y = player.jump_velocity
	player.check_flip(direction)
	is_wall_jumping = true
	wall_jump_input_timer = wall_jump_input_th
	
