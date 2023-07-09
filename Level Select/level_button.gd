class_name LevelButton
extends HBoxContainer

signal pressed()

var level: int = -1

func _on_play_pressed() -> void:
	pressed.emit()


func set_text(text: String) -> void:
	$Play.text = text
	

func set_progress() -> void:
	var progress: Dictionary = LevelProgress.get_progress(level)
	$Label.text = "%d/%d turns" % [progress.turns, progress.min_turns]
