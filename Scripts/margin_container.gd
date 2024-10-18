extends HBoxContainer


@onready var health_1: Sprite2D = $Control/Health1
@onready var health_2: Sprite2D = $Control2/Health2
@onready var health_3: Sprite2D = $Control3/Health3
var children: Array[Node]

func _ready()->void:
	children = get_children()
	GameManager.connect("health_updated", Callable(self, "_on_global_health_updated"))


func _on_global_health_updated(health)->void:
	for i in children.size():
		if(i+1  > health):
			print(children[i], i)
			children[i].set_full(false)
		pass
		
