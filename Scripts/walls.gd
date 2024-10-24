extends TileMapLayer


func destroy_cells(global_position:Vector2, direction: Vector2, neighbors:int = 1):
	var tile : Vector2 = local_to_map(global_position)
	var targets: Array[Vector2i] = get_surrounding_cells(tile)
	print(tile)
	for i in neighbors:
		for j in abs(i - neighbors):
			BetterTerrain.set_cell(self,tile+Vector2(i,j) + direction, -1)
			BetterTerrain.set_cell(self,tile+Vector2(i,-j) + direction, -1)
			BetterTerrain.set_cell(self,tile+Vector2(-i,j) + direction, -1)
			BetterTerrain.set_cell(self,tile+Vector2(-i,-j) + direction, -1)
	BetterTerrain.update_terrain_area(self, Rect2i(tile-Vector2(neighbors,neighbors),Vector2(neighbors,neighbors)*2)  )
#var ZERO:int = 0
#
func _input(event) -> void:
	if event.is_action_pressed("Alt Click"):
		var tile : Vector2 = local_to_map(get_global_mouse_position())
		erase_cell(tile)
