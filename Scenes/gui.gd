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
@onready var resume_button: Control = $PauseMenu/VBoxContainer/HBoxContainer/Resume

func _ready() -> void:
	unpause()
	turn_passed(0)
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_on_pause_pressed()
	elif event.is_action_pressed("reset"):
		_on_reset_pressed()
	

func pause() -> void:
	get_tree().paused = true
	pause_menu.show()
	SoundManager.muffle_music(true)


func unpause() -> void:
	get_tree().paused = false
	pause_menu.hide()
	SoundManager.muffle_music(false)
	

func turn_passed(new_turn: int) -> void:
	$"MarginContainer3/Scene Counter/Counter".text = str(new_turn)


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


func _on_scene_counter_mouse_entered() -> void:
	scene_counter.modulate = Color(1.0, 1.0, 1.0, 0.5)


func _on_scene_counter_mouse_exited() -> void:
	scene_counter.modulate = Color(1.0, 1.0, 1.0, 1.0)
