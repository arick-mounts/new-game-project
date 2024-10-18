extends Node
enum States {PLAYING, MENU, PAUSED, OVER}

var score = 0
var state =  States.PLAYING : set = set_state
var health = 4
func _ready() -> void:
	GameManager.connect("health_depleted", Callable(self, "_on_global_health_depleted"))
	
func update_score(val:int)->void:
	score+=val
	score_updated.emit()

func quit()->void:
	get_tree().quit()

func set_state(newState:States)->void:
	var prevState = state
	state = newState
	if(state == States.OVER):
		get_tree().paused = true
	state_changed.emit(state)
	
func start_game()->void:
	health = 4
	score = 0
	get_tree().change_scene_to_file("res://Scenes/Level.tscn")
func start_menu()->void:
	get_tree().paused= false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
func restart()->void:
	var tree = get_tree()
	health = 4
	score = 0
	tree.reload_current_scene()
	tree.paused= false
	
func reduce_health()->void:
	if(health > 0):
		health-=1
		if(health == 0):
			health_depleted.emit()	
			state = States.OVER
		health_updated.emit(health)
			
signal health_updated(health:int)
signal health_depleted
signal score_updated
signal state_changed(state:States)
