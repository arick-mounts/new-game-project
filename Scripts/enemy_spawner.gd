extends Node2D

@export  var rect:Rect2
@export var disabled:bool = false
const debug = preload("res://Scripts/spawnerDebug.gd")
@onready var timer: Timer = $Timer


func gen_random_pos():
	var x = randi_range(rect.position.x, rect.position.x+rect.size.x)
	var y = randi_range(rect.position.y, rect.position.y+rect.size.y)
	return Vector2(x, y)

func _on_ready() -> void:
	timer.start(3)

var scene_to_instance = preload("res://Scenes/Enemy.tscn")
func instance_object():
	for n in randi_range(1, 12):
		var object = scene_to_instance.instantiate()
		object.position = gen_random_pos()
		call_deferred("add_child",object) 

func _on_timer_timeout() -> void:
	if(!disabled && get_tree().get_nodes_in_group("enemy").size() < 30 ):
		instance_object()
	timer.start(6)
