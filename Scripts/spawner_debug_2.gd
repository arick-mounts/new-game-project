@tool
extends "res://Scripts/enemy_spawner.gd"

func _draw():
	if Engine.is_editor_hint():
		draw_rect(rect, Color(.7,.7,.7,.5))
