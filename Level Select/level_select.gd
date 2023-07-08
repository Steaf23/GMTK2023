@tool
class_name LevelSelect
extends Control

signal level_btn_pressed()

@onready var levels = $MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/Levels
@onready var LEVEL_BTN: PackedScene = preload("res://Level Select/level_button.tscn")

var pattern = RegEx.new()

func _ready() -> void:
	pattern.compile("level_(?<level>\\d+)\\.tscn")
	for file in DirAccess.get_files_at("res://Levels"):
		var result = pattern.search(file)
		if result:
			var level = result.get_string("level").to_int()
			var level_btn = LEVEL_BTN.instantiate()
			level_btn.text = " Level %d " % (level + 1)
			level_btn.set_meta("level", level)
			levels.add_child(level_btn)

	for child in levels.get_children():
		if child is Button and child.has_meta("level"):
			child.pressed.connect(func ():
				level_btn_pressed.emit(child.get_meta("level")))
	
