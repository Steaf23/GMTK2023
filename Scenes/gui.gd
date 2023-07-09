class_name GUI
extends CanvasLayer

signal reset_pressed()
signal menu_pressed()
signal play_pressed()

@onready var pause_menu = $PauseMenu
@onready var play_button: Button = $MarginContainer/Play
@onready var home_button: Button = $PauseMenu/VBoxContainer/HBoxContainer/Home
@onready var reset_button: Button = $PauseMenu/VBoxContainer/HBoxContainer/Reset
@onready var scene_counter: Control = $"MarginContainer3/Scene Counter"

func _ready() -> void:
	unpause()
	turn_passed(0)
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_on_pause_pressed()
	

func pause() -> void:
	get_tree().paused = true
	pause_menu.show()


func unpause() -> void:
	get_tree().paused = false
	pause_menu.hide()
	

func turn_passed(new_turn: int) -> void:
	$"MarginContainer3/Scene Counter/Counter".text = str(new_turn + 1)


func _on_pause_pressed() -> void:
	SoundManager.play_sfx("res://Assets/Audio/SFX/click.wav")
	if get_tree().paused:
		unpause()
	else:
		pause()
		

func _on_reset_pressed() -> void:
	unpause()
	SoundManager.play_sfx("res://Assets/Audio/SFX/click.wav")
	reset_pressed.emit()


func _on_home_pressed() -> void:
	# TODO: send to menu/level select
	SoundManager.play_sfx("res://Assets/Audio/SFX/click.wav")
	unpause()
	menu_pressed.emit()


func _on_play_pressed() -> void:
	SoundManager.play_sfx("res://Assets/Audio/SFX/click.wav")
	play_pressed.emit()


func _on_resume_pressed() -> void:
	SoundManager.play_sfx("res://Assets/Audio/SFX/click.wav")
	unpause()
