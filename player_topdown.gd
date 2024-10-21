extends CharacterBody2D

var speed = 150  # speed in pixels/sec
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animated_sprite_2d_2: AnimatedSprite2D = $HitRotate/HitBox/AnimatedSprite2D2
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_rotate: Area2D = $HitRotate

var local_collision_pos : Vector2

	
	
func _physics_process(delta):
	if(Input.is_action_just_pressed("attack")):
		if animation_player.get_queue().size()<2:
			animation_player.queue("Attack")
	var direction = Input.get_vector("left", "right", "up", "down")
	var lookDirection = global_position.direction_to(get_global_mouse_position())
	if(abs(lookDirection[1]) > abs(lookDirection[0])):
		if lookDirection[1]>0 :
			animated_sprite.play("Walk_D")
		elif lookDirection[1]<0:
			animated_sprite.play("Walk_U")
	else:
		if lookDirection[0]>0 :
			animated_sprite.play("Walk_R")
		elif lookDirection[0]<0:
			animated_sprite.play("Walk_L")

	hit_rotate.rotation = position.direction_to(get_global_mouse_position()).angle()
	
	velocity = direction * speed

	move_and_slide()



func _on_hit_rotate_body_entered(body: Node2D) -> void:
	if(body.is_in_group("hurt_box")):
		body.take_damage()
	if(body.is_in_group("mineable")):
		var lookDirection :Vector2 = global_position.direction_to(get_global_mouse_position())
		var collision_position: Vector2 =(lookDirection * 2 * 16)  + get_position()
		body.destroy_cells(collision_position, lookDirection, 3)
 # Replace with function body.
