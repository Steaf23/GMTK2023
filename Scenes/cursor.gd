extends Node2D


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("select"):
		$Sprite2D.material.set_shader_parameter("enabled", true)
	if event.is_action_released("select"):
		$Sprite2D.material.set_shader_parameter("enabled", false)
