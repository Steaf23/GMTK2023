class_name Actor
extends Area2D

signal clicked()

@export var mask: Mask:
	set(new_mask):
		mask = new_mask
		if mask_sprite == null:
			await self.ready
		
		if new_mask != null:
			mask_sprite.texture = mask.texture
		
@onready var mask_sprite = $MaskSprite

var selected = false


func _ready() -> void:
	self.mask = mask


# Determine position based on mask
func get_mask_target_pos() -> Vector2i:
	if mask == null:
		return Vector2i()
		
	return mask.next_pos


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("select"):
		clicked.emit()


func _on_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
