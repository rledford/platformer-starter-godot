extends Node

func _ready():
	_global.viewport_container = $SubViewportContainer
	_global.viewport = $SubViewportContainer/SubViewport
