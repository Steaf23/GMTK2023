extends Node

@export var level_pattern = "res://Levels/level_%d.tscn"

@onready var LEVEL_SELECT: PackedScene = preload("res://Level Select/level_select.tscn")
@onready var END_SCREEN: PackedScene = preload("res://Scenes/end_screen.tscn")
# Change this when selecting a level from the menu 
@onready var first_level: int = 0
@onready var gui: GUI = $GUI

var current_level: int


func _ready() -> void:
	gui.play_button.disabled = false
	switch(first_level)
	

func has_level(level: int) -> bool:
	return ResourceLoader.exists(level_pattern % level)


func switch(new_level: int) -> void:
	gui.scene_counter.visible = new_level != first_level
	current_level = new_level
	
	for c in $Level.get_children():
		c.queue_free()
	
	var scn: Level
	if current_level == -1:
		scn = load("res://Levels/level_0.tscn").instantiate()
	else:
		scn = load(level_pattern % new_level).instantiate()
		
	scn.turn_passed.connect(func(turn: int): gui.turn_passed(turn))
	scn.level_won.connect(_on_level_won.bind(new_level))
	scn.turn_started.connect(func(): gui.play_button.disabled = true)
	scn.turn_finished.connect(func(): gui.play_button.disabled = false)
	$Level.add_child(scn)
	


func _on_level_won(turns: int, level: int) -> void:
	print(level, current_level)
	LevelProgress.set_progress(level, turns)
	
	gui.play_button.disabled = false
	var new_level = level + 1
	if has_level(new_level):
		switch(new_level)
	else:
		switch_to_end()
		print("THANKS FOR PLAYING")


func _on_gui_menu_pressed() -> void:
	for c in $Level.get_children():
		c.queue_free()
		
	var level_select_scn: LevelSelect = LEVEL_SELECT.instantiate()
	level_select_scn.level_btn_pressed.connect(_on_level_chosen)
	$Level.add_child(level_select_scn)
	
	gui.play_button.hide()
	gui.home_button.hide()
	gui.reset_button.hide()
	gui.scene_counter.hide()


func switch_to_end() -> void:
	for c in $Level.get_children():
		c.queue_free()
		
	var end_screen_scn: EndScreen = END_SCREEN.instantiate()
	end_screen_scn.home_pressed.connect(_on_gui_menu_pressed)
	$Level.add_child(end_screen_scn)
	
	gui.reset_button.hide()
	gui.play_button.hide()
	gui.reset_button.hide()
	gui.scene_counter.hide()


func _on_gui_reset_pressed() -> void:
	switch(current_level)


func _on_gui_play_pressed() -> void:
	if $Level.get_child_count() == 0:
		return
		
	var level_node: Level = $Level.get_child(0)
	level_node.play_turn()


func _on_level_chosen(level: int) -> void:
	SoundManager.play_sfx("res://Assets/Audio/SFX/click.wav")
	gui.reset_button.show()
	gui.play_button.show()
	gui.home_button.show()
	gui.reset_button.show()
	gui.scene_counter.visible = level != first_level
	switch(level)
