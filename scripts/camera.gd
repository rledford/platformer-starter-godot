extends Camera2D

@export var player_node: NodePath
@onready var player: Player = get_node(player_node)

var game_size := Vector2(480, 320)
@onready var window_scale := (DisplayServer.screen_get_size() / Vector2i(game_size)).x
@onready var actual_cam_pos := global_position

func _physics_process(delta):
	var player_pos = player.global_position + Vector2(0, -56)
	actual_cam_pos = lerp(actual_cam_pos, player_pos, delta*5)
	var subpixel_position = actual_cam_pos.round() - actual_cam_pos
	_global.viewport_container.material.set("cam_offset", subpixel_position)
	global_position = actual_cam_pos.round()
