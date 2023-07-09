extends Node

var progress = []

var pattern = RegEx.new()
@onready var min_turns = load("res://Level Select/level_min_turns.tres")


func _ready() -> void:
	pattern.compile("level_(?<level>\\d+)\\.tscn")
	for file in DirAccess.get_files_at("res://Levels"):
		var result = pattern.search(file)
		if result:
			var level = result.get_string("level").to_int()
			if (min_turns.levels.size() > level):
				add_level(min_turns.levels[level])

func add_level(min_turns: int) -> void:
	progress.append({"turns": 0, "min_turns": min_turns})


func get_progress(level: int) -> Dictionary:
	return progress[level]


func set_progress(level: int, turns: int) -> void:
	if progress.size() > level:
		progress[level].turns = turns
