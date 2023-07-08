extends CanvasLayer

signal reset_pressed()
signal menu_pressed()

@onready var pause_menu = $PauseMenu


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_on_button_pressed()
		

func _on_button_pressed() -> void:
	if get_tree().paused:
		unpause()
	else:
		pause()
	

func pause() -> void:
	get_tree().paused = true
	pause_menu.show()


func unpause() -> void:
	get_tree().paused = false
	pause_menu.hide()


func _on_reset_pressed() -> void:
	unpause()
	reset_pressed.emit()


func _on_home_pressed() -> void:
	# TODO: send to menu/level select
	unpause()
	menu_pressed.emit()
