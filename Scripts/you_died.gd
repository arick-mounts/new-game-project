extends Control
@onready var label: Label = $Label
@onready var control: Control = $Control
var pause_menu: PackedScene
func _ready() -> void:
	pause_menu = preload("res://Scenes/YouDied.tscn")
	GameManager.connect("health_depleted", Callable(self, "_on_global_health_depleted"))
	
func _on_global_health_depleted():
	print("DEAD")
	add_child(pause_menu.instantiate())
