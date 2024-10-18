extends Control
@onready var label: Label = $Label

func _ready() -> void:
	
	GameManager.connect("health_depleted", Callable(self, "_on_global_health_depleted"))
func _on_global_health_depleted():
	visible = true
	print("PAUSED")


func _on_button_pressed() -> void:
	GameManager.restart()


func _on_button_2_pressed() -> void:
	GameManager.start_menu()
