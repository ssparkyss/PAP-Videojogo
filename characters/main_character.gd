extends CharacterBody2D

var move_speed = 50000
var health: float = 20
var current_look_dir = "right"
var can_slash: bool = true
var facing_direction = 1  
@export var slash_time: float = 0.4

func _on_mc_hurtbox_area_entered(area: Area2D) -> void:
	if area is Area2D and area.is_in_group("Hitbox"):
		$HitSound.play()
		health -= 1
		if health <= 0.0:
			get_tree().change_scene_to_file(str("res://scenes/levelselect.tscn"))

func _physics_process(delta: float) -> void:
	var input = Vector2(Input.get_action_strength("MoveRight")-
	Input.get_action_strength("MoveLeft"),
	Input.get_action_strength("MoveDown")- 
	Input.get_action_strength("MoveUp")).normalized()
	
	velocity = input * move_speed * delta
	move_and_slide()
	
	var _animation_player = $MCSprite/MCAnimation
	var _sword_animation = $MCSprite/MCEspada/EspadaAnimation
	
	if Input.get_action_strength("MoveDown"):
		_animation_player.play("walk")
	elif Input.get_action_strength("MoveUp"):
		_animation_player.play("walk")
	elif Input.get_action_strength("MoveRight"):
		_animation_player.play("walk")
	elif Input.get_action_strength("MoveLeft"):
		_animation_player.play("walk")
	else: _animation_player.play("idle")
	
	if current_look_dir == "right" and get_global_mouse_position().x < global_position.x:
		_animation_player.play("look_right")
		current_look_dir = "left"
	elif current_look_dir == "left" and get_global_mouse_position().x > global_position.x:
		_animation_player.play("look_left")
		current_look_dir = "right"
	
	if velocity.x > 0:
		facing_direction = 1
	elif velocity.x < 0:
		facing_direction = -1
	
	if Input.is_action_pressed("attack") and can_slash:
		_sword_animation.speed_scale = _sword_animation.get_animation("slash").length / slash_time
		_sword_animation.play("slash")
		can_slash = true
		
	if Input.is_action_pressed("dodge"):
		move_speed = 500000.0
		await get_tree().create_timer(0.05).timeout
		move_speed = 50000.0
