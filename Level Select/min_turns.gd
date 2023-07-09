class_name MinimumTurns
extends Resource

@export var levels: PackedInt32Array = []

func get_min_turns(level: int) -> int:
	if levels.size() < level:
		return INF
	else:
		return levels[level]
