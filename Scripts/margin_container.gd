extends HBoxContainer

@onready var health_1: Sprite2D = $Control/Health1
@onready var health_2: Sprite2D = $Control2/Health2
@onready var health_3: Sprite2D = $Control3/Health3


func _ready()->void:
	GameManager.connect("health_change", Callable(self, "_on_global_health_updated"))


func _on_global_health_updated(health)->void:
	if(health < 3):
		health_3.texture = load("res://Assets/Sprites/Char_002.png")
