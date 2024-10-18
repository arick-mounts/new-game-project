extends CharacterBody2D

var speed = 400  # speed in pixels/sec
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animated_sprite_2d_2: AnimatedSprite2D = $HitRotate/HitBox/AnimatedSprite2D2
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_rotate: Area2D = $HitRotate

func _physics_process(delta):
	if(Input.is_action_just_pressed("attack")):
		if animation_player.get_queue().size()<2:
			animation_player.queue("Attack")
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction[1]>0 :
		animated_sprite.play("Walk_D")
		hit_rotate.rotation_degrees= 0
	elif direction[1]<0:
		animated_sprite.play("Walk_U")
		hit_rotate.rotation_degrees = 180
	elif direction[0]>0 :
		animated_sprite.play("Walk_R")
		hit_rotate.rotation_degrees = 270
	elif direction[0]<0:
		animated_sprite.play("Walk_L")
		hit_rotate.rotation_degrees = 90
	velocity = direction * speed

	move_and_slide()



func _on_hit_rotate_body_entered(body: Node2D) -> void:
	if(body.is_in_group("hurt_box")):
		body.take_damage()
 # Replace with function body.
