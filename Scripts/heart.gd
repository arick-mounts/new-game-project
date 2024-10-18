class_name Heart
extends Control
@onready var empty_sprite: Sprite2D = $EmptySprite
@onready var full_sprite: Sprite2D = $FullSprite


@export var full: bool = true : set = set_full

func set_full (newval:bool)->void:
	if(!newval):
		full_sprite.visible = false 
		empty_sprite.visible = true
	else:
		full_sprite.visible = true 
		empty_sprite.visible = false
		
