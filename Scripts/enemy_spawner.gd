extends Node2D

@export  var rect:Rect2
@export var disabled:bool = false
const debug = preload("res://Scripts/spawnerDebug.gd")
@onready var timer: Timer = $Timer
@onready var walls : TileMapLayer

func _draw():
	if Engine.is_editor_hint():
		draw_rect(rect, Color(.7,.7,.7,.5))
		
func gen_random_pos():
	var x = randi_range(rect.position.x, rect.position.x+rect.size.x)
	var y = randi_range(rect.position.y, rect.position.y+rect.size.y)
	return Vector2(x, y)

func _on_ready() -> void:
	timer.start(3)
	
var scene_to_instance = preload("res://Scenes/Enemy.tscn")
func instance_object():
	for n in randi_range(1, 12):
		var pos = gen_random_pos()
		var space_state = get_world_2d().direct_space_state
		var iteration = 0
		var shape_rid = PhysicsServer2D.circle_shape_create()
		var radius = 2
		PhysicsServer2D.shape_set_data(shape_rid, radius)

		var query = PhysicsShapeQueryParameters2D.new()
		query.shape_rid = shape_rid
		query.transform = Transform2D(0, pos)
		query.collide_with_areas = true
		var result = space_state.intersect_shape(query)
		PhysicsServer2D.free_rid(shape_rid) 
		print(result)
		#while result.size() > 0 && iteration < 3:
			#var new_pos = gen_random_pos()
			#query.transform = Transform2D(0, new_pos)
			#result = space_state.intersect_shape((query))
			#iteration+=1
			#print(result)
		if(result.size() <=0):
			print(result)
			var object : Enemy = scene_to_instance.instantiate()
			object.position = pos
			call_deferred("add_child",object) 
		else:
			print(pos)
		

func _on_timer_timeout() -> void:
	if(!disabled && get_tree().get_nodes_in_group("enemy").size() < 30 ):
		instance_object()
	timer.start(6)
