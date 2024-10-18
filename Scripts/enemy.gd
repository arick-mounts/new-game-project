extends CharacterBody2D

@onready var death = $Death
@onready var spawn = $Spawn
@onready var area_2d: CollisionShape2D = $Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var enemy: CharacterBody2D = $"."
@onready var player_detector: Area2D = $PlayerDetector
@onready var hit_box_shape: CollisionShape2D = $HitBox/HitBoxShape
@onready var hit_box_reset: Timer = $HitBox/HitBoxReset



var speed = 75  # speed in pixels/sec

enum States {IDLE, ATTACKING, DIEING, DEAD}

var state : States = States.IDLE : set = set_state

func _physics_process(delta: float) -> void:
	
	var direction:Vector2 = Vector2(0,0)
	
	if(state == States.ATTACKING):
		var player:Node2D
		for body in  player_detector.get_overlapping_bodies():
			if body.is_in_group("player"):
				player=body
				break
		direction = global_position.direction_to((player.global_position))
		animated_sprite_2d.flip_h = direction.x < 0
		animated_sprite_2d.play("Walking")
	else:
		animated_sprite_2d.play("Idle")
		
	velocity = direction * speed
	move_and_slide()
		

func take_damage():
	state = States.DIEING

func _ready() -> void:
	spawn.emitting = true


func _on_death_finished() -> void:
	queue_free()


func set_state(new_state:int) ->void:
	var prevState := state
	if(prevState == States.DIEING):
		return
	state = new_state
	

	if state == States.DIEING && prevState != States.DIEING:
		area_2d.set_deferred("disabled", true)
		hit_box_shape.set_deferred("disabled", true)
		animated_sprite_2d.visible = false
		GameManager.update_score(100)
		death.emitting = true


func _on_player_detector_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		set_state(States.ATTACKING)
		


func _on_player_detector_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		set_state(States.IDLE)


func _on_area_2d_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.reduce_health()
		hit_box_shape.set_deferred("disabled", true)
		hit_box_reset.start()


func _on_hit_box_reset_timeout() -> void:
	if(state != States.DIEING):
		hit_box_shape.set_deferred("disabled", false)
	
