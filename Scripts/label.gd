extends Label

func _ready():
	GameManager.connect("score_updated", Callable(self, "_on_global_score_updated"))
	
func _on_global_score_updated()->void:
	text = "Score: " + str(GameManager.score)
