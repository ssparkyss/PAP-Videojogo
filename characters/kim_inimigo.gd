extends CharacterBody2D

@onready var player = $"../MainCharacter"
@onready var KimAnimation = $KimSprite/KimAnimation
@onready var EspadaAnimation = $KimSprite/KimEspada/EspadaAniation
var health: float = 25
var speed: float = 700
var chase : bool = true

func _ready() -> void:
	add_to_group("enemy")
	
func _on_kim_visao_area_entered(area: Area2D) -> void:
	if area is Area2D and area.is_in_group("Hurtbox"):
		EspadaAnimation.call_deferred("play", "attack")
func _on_kim_visao_area_exited(area: Area2D) -> void:
	if area is Area2D and area.is_in_group("Hurtbox"):
		EspadaAnimation.call_deferred("stop")

func _on_kim_hurtbox_area_entered(area: Area2D) -> void:
	if area is Area2D and area.is_in_group("Hitbox"):
		$HitSound.play()
		health -= 1
		if health <= 0.0:
			queue_free()

var current_look_dir = "left"
func _physics_process(delta: float) -> void:

	if chase:
		var side_offset = Vector2(player.facing_direction * 300, 0)
		var target_position = player.global_position + side_offset
	
		var direction = (target_position - global_position).normalized()
		velocity = lerp(velocity, direction * speed, 8.5 * delta)
		move_and_slide()
		
		
	if current_look_dir == "left" and player.global_position.x > global_position.x:
		KimAnimation.play("look_right")
		await KimAnimation.animation_finished
		KimAnimation.play("walk")
		current_look_dir = "right"
	elif current_look_dir == "right" and player.global_position.x < global_position.x:
		KimAnimation.play("look_left")
		await KimAnimation.animation_finished
		KimAnimation.play("walk")
		current_look_dir = "left"
