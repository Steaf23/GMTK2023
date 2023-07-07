extends TileMap

@onready var actors = $Actors

var selected_actor: Actor = null


func _ready() -> void:
	for child in actors.get_children():
		if child is Actor:
			child.clicked.connect(_on_actor_clicked.bind(child))
	
	show_target_tiles()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("turn"):
		play_turn()


func play_turn() -> void:
	for child in actors.get_children():
		if child is Actor:
			var target_cell = local_to_map(child.global_position) + child.get_mask_target_pos()
			if can_move_to_tile(child, target_cell):
				child.global_position = map_to_local(target_cell)
			else:
				"I cannot move!"
	show_target_tiles()


func show_target_tiles() -> void:
	clear_layer(1)
	for child in actors.get_children():
		if child is Actor:
			var target_cell = local_to_map(child.global_position) + child.get_mask_target_pos()
			set_cell(1, target_cell, 2, Vector2i())


func _on_actor_clicked(actor: Actor) -> void:
	if selected_actor == null || selected_actor == actor:
		selected_actor = actor
	else:
		switch_masks(actor, selected_actor)
		

func switch_masks(actor1: Actor, actor2: Actor) -> void:
	var tmp = actor1.mask
	actor1.mask = actor2.mask
	actor2.mask = tmp
	
	selected_actor = null
	show_target_tiles()


func can_move_to_tile(actor: Actor, tile: Vector2i) -> bool:
	return get_cell_source_id(0, tile) != 1
		
	
	
