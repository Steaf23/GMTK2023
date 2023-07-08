extends Node

@export var level_pattern = "res://Levels/level_%d.tscn"

# Change this when selecting a level from the menu 
@onready var first_level: int = 0

var current_level: int


func _ready() -> void:
	switch(first_level)
	

func has_level(level: int) -> bool:
	return ResourceLoader.exists(level_pattern % level)


func switch(new_level: int) -> void:
	current_level = new_level
	
	for c in $Level.get_children():
		c.queue_free()
		
	var scn: Level = load(level_pattern % new_level).instantiate()
	$Level.add_child(scn)
	scn.level_won.connect(_on_level_won.bind(new_level))


func _on_level_won(level: int) -> void:
	var new_level = level + 1
	if has_level(new_level):
		switch(new_level)
	else:
		print("THANKS FOR PLAYING")


func _on_gui_menu_pressed() -> void:
	switch(current_level)


func _on_gui_reset_pressed() -> void:
	switch(current_level)


func _on_gui_play_pressed() -> void:
	var level_node: Level = $Level.get_child(0)
	if level_node == null:
		return
	
	level_node.play_turn()
	
