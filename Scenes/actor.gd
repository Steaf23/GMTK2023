@tool
class_name Actor
extends Area2D

const TILE_SIZE = 32
const MASK_OFFSET = Vector2(16, 4)

signal clicked()
signal mask_move_finished()

@export var mask: Mask:
	set(new_mask):
		mask = new_mask
		if mask_sprite == null:
			await self.ready
		
		if new_mask != null:
			mask_sprite.texture = new_mask.texture
			target.global_position = current_cell * TILE_SIZE + new_mask.next_pos * TILE_SIZE
			target.modulate = new_mask.color
		
@onready var mask_sprite = $MaskSprite
@onready var target = $Target
@onready var sfx = load("res://Assets/Audio/Resources/sfx.tres")

var current_cell: Vector2i
var current_tween: Tween = null


func _ready() -> void:
	self.mask = mask
	current_cell = global_position / TILE_SIZE
	

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		self.mask = mask


# Determine position based on mask
func get_mask_target_pos() -> Vector2i:
	if mask == null:
		return Vector2i()
		
	return mask.next_pos


func throw_mask(target_position: Vector2i) -> void:
	var mask_tween_pos = create_tween()
	var tweener = mask_tween_pos.tween_property(mask_sprite, "global_position", Vector2(target_position) + MASK_OFFSET, 1.0)
	tweener.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	
	var mask_tween_rot = create_tween()
	var tweener2 = mask_tween_rot.tween_property(mask_sprite, "rotation_degrees", 360, 1.0)
	tweener2.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT).from(0)
	
	mask_tween_pos.finished.connect(_on_mask_thrown)


func move() -> void:
	if mask == null:
		return
		
#	if current_tween != null && current_tween.is_running():
#		current_tween.stop()
#		global_position = current_cell * TILE_SIZE
		
	var target = current_cell * TILE_SIZE + mask.next_pos * TILE_SIZE
	current_cell += mask.next_pos
	
	var distance = global_position.distance_to(target)
	current_tween = create_tween()
	current_tween.tween_property(self, ^"global_position", Vector2(target), 0.3)
	

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("select"):
		# get_node("/root/SoundManager").play_sfx(sfx.masks[self.mask])
		clicked.emit()


func _on_mouse_entered() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)


func _on_mouse_exited() -> void:
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)


func _on_mask_thrown() -> void:
	mask_sprite.global_position = global_position + MASK_OFFSET
	mask_move_finished.emit()
