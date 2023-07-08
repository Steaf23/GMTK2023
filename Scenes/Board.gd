extends TileMap

@onready var actors = $Actors
@onready var targets = $Targets

var selected_actor: Actor = null


func _ready() -> void:
	for child in actors.get_children():
		if child is Actor:
			child.clicked.connect(_on_actor_clicked.bind(child))


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("turn"):
		play_turn()


func play_turn() -> void:
	for child in actors.get_children():
		if child is Actor:
			var target_cell = local_to_map(child.global_position) + child.get_mask_target_pos()
			if can_move_to_tile(child, target_cell):
				child.global_position = map_to_local(target_cell)
	
	check_win()


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
	check_win()


func can_move_to_tile(actor: Actor, cell: Vector2i) -> bool:
	return get_actor_on_tile(cell) == null && get_cell_tile_data(0, cell).get_custom_data("collision") != 1
	
	
func get_actor_on_tile(cell: Vector2i) -> Actor:
	for child in actors.get_children():
		if child is Actor:
			if local_to_map(child.global_position) == cell:
				return child
	return null


func check_win() -> void:
	var all_targets = true
	for child in targets.get_children():
		if child is Target:
			var actor = get_actor_on_tile(local_to_map(child.global_position))
			if actor == null || actor.mask != child.mask:
				all_targets = false
	
	if all_targets:
		print("YOU WON!")
