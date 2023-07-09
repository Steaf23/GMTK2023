@tool
class_name Target
extends Node2D

@export var mask: Mask:
	set(new_mask):
		mask = new_mask
		if new_mask != null:
			$Overlay.modulate = mask.color
