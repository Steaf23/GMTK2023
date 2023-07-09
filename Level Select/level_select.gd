@tool
class_name LevelSelect
extends Control

signal level_btn_pressed()

@onready var levels = $MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Levels
@onready var LEVEL_BTN: PackedScene = preload("res://Level Select/level_button.tscn")


func _ready() -> void:
	for level in range(0, LevelProgress.progress.size()):
		print(level)
		var level_btn = LEVEL_BTN.instantiate()
		level_btn.set_text(" Level %d " % (level + 1))
		level_btn.level = level
		levels.add_child(level_btn)
		level_btn.set_progress()
			

	for child in levels.get_children():
		if child is LevelButton:
			child.pressed.connect(func ():
				level_btn_pressed.emit(child.level))
	
