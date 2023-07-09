extends Level

@onready var tutorial = $Tutorial

var tutorial_finished = false


func _ready() -> void:
	super._ready()
	
	tutorial.hide()


func check_win() -> void:
	super.check_win()
	
	var a1 = get_actor_on_tile(Vector2i(8, 5))
	var a2 = get_actor_on_tile(Vector2i(10, 5))
	if (a1 != null && a2 != null && !tutorial_finished):
		tutorial.show()
		tutorial_finished = true


func switch_masks(a1, a2) -> void:
	super.switch_masks(a1, a2)
	
	tutorial.hide()
	tutorial_finished = true
