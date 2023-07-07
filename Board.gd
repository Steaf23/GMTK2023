extends TileMap

@onready var actors = $Actors

var selected_actor: Actor = null


func _ready() -> void:
	for child in actors.get_children():
		if child is Actor:
			child.clicked.connect(_on_actor_clicked.bind(child))


func can_move(cell: Vector2i) -> bool:
	return true


func play_turn() -> void:
	pass


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
