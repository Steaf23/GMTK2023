class_name EndScreen
extends Control

signal home_pressed()

func _on_home_pressed() -> void:
	home_pressed.emit()
