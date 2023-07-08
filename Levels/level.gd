class_name Level
extends TileMap

signal level_won()

@onready var actors = $Actors
@onready var targets = $Targets

var selected_actor: Actor = null

var turn: int = 0


func _ready() -> void:
	for t in get_used_cells_by_custom_data(0, "collision", 1):
		if t.x % 2 == t.y % 2:
			$Grid.set_cell(0, t, 0, Vector2i())
	
	for child in actors.get_children():
		if child is Actor:
			child.clicked.connect(_on_actor_clicked.bind(child))
		

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("turn"):
		play_turn()


func play_turn() -> void:
	for child in actors.get_children():
		if child is Actor:
			var target_cell = child.current_cell + child.get_mask_target_pos()
			if can_move_to_tile(child, target_cell):
				child.move()
	
	turn += 1
	check_win()


func _on_actor_clicked(actor: Actor) -> void:
	if selected_actor == null || selected_actor == actor:
		selected_actor = actor
	else:
		switch_masks(actor, selected_actor)
		

func switch_masks(actor1: Actor, actor2: Actor) -> void:
	actor1.throw_mask(actor2.global_position)
	actor2.throw_mask(actor1.global_position)
	actor1.mask_move_finished.connect(
	func (): 
		var tmp = actor1.mask
		actor1.mask = actor2.mask
		actor2.mask = tmp
	
		selected_actor = null
		check_win()
	, CONNECT_ONE_SHOT)


func can_move_to_tile(actor: Actor, cell: Vector2i) -> bool:
	if get_cell_tile_data(0, cell) == null:
		return false
	return get_actor_on_tile(cell) == null && get_cell_tile_data(0, cell).get_custom_data("collision") == 1
	
	
func get_actor_on_tile(cell: Vector2i) -> Actor:
	for child in actors.get_children():
		if child is Actor:
			if child.current_cell == cell:
				return child
	return null


func check_win() -> void:
	if targets.get_child_count() == 0:
		return
		
	var all_targets = true
	for child in targets.get_children():
		if child is Target:
			var actor = get_actor_on_tile(local_to_map(child.global_position))
			if actor == null || actor.mask != child.mask:
				all_targets = false
	
	if all_targets:
		print("Level finished in {0} turn(s)".format([turn]))
		level_won.emit()


func get_used_cells_by_custom_data(layer: int, data_name: StringName, data_value: Variant) -> Array[Vector2i]:
	var result: Array[Vector2i] = []
	for t in get_used_cells(layer):
		if get_cell_tile_data(layer, t).get_custom_data(data_name) == data_value:
			result.append(t)
	return result
