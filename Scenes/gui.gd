class_name GUI
extends CanvasLayer

signal reset_pressed()
signal menu_pressed()
signal play_pressed()

@onready var pause_menu = $PauseMenu
@onready var play_button: Button = $MarginContainer/Play
@onready var home_button: Button = $PauseMenu/VBoxContainer/HBoxContainer/Home
@onready var reset_button: Button = $PauseMenu/VBoxContainer/HBoxContainer/Reset


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_on_pause_pressed()
	

func pause() -> void:
	get_tree().paused = true
	pause_menu.show()


func unpause() -> void:
	get_tree().paused = false
	pause_menu.hide()


func _on_pause_pressed() -> void:
	if get_tree().paused:
		unpause()
	else:
		pause()
		

func _on_reset_pressed() -> void:
	unpause()
	reset_pressed.emit()


func _on_home_pressed() -> void:
	# TODO: send to menu/level select
	unpause()
	menu_pressed.emit()


func _on_play_pressed() -> void:
	play_pressed.emit()


func _on_resume_pressed() -> void:
	unpause()
