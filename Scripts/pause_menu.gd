extends Control

func _on_button_pressed() -> void:
	GameManager.restart()


func _on_button_2_pressed() -> void:
	GameManager.start_menu()
