class_name Target
extends Node2D

@export var mask: Mask

func _ready() -> void:
	if mask != null:
		$Sprite2D.modulate = mask.color
