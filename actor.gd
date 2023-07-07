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


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("select"):
		clicked.emit()
