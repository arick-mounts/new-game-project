extends Node

var score = 0

func update_score(val:int)->void:
	score+=val
	score_updated.emit()

signal score_updated

var health = 3
func _process(delta: float) -> void:
	print(health)
	
func reduce_health()->void:
	if(health > 0):
		health-=1
		if(health == 0):
			health_depleted.emit()
		else:
			health_updated.emit(health)
			
signal health_updated(health:int)
signal health_depleted
