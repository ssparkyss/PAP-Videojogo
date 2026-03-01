extends CharacterBody2D

@onready var player = $"../MainCharacter"
@onready var ArgaliaAnimation = $ArgaliaSprite/ArgaliaAnimation
@onready var FoiceAnimation = $ArgaliaSprite/ArgaliaFoice/FoiceAnimation
var health: float = 35
var speed: float = 1200
var chase : bool = true

func _ready() -> void:
	add_to_group("enemy")
	
func _on_argalia_visao_area_entered(area: Area2D) -> void:
	if area is Area2D and area.is_in_group("Hurtbox"):
		FoiceAnimation.call_deferred("play", "attack")
func _on_argalia_visao_area_exited(area: Area2D) -> void:
	if area is Area2D and area.is_in_group("Hurtbox"):
		FoiceAnimation.call_deferred("stop")

func _on_argalia_hurtbox_area_entered(area: Area2D) -> void:
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
		ArgaliaAnimation.play("look_right")
		await ArgaliaAnimation.animation_finished
		ArgaliaAnimation.play("walk")
		current_look_dir = "right"
	elif current_look_dir == "right" and player.global_position.x < global_position.x:
		ArgaliaAnimation.play("look_left")
		await ArgaliaAnimation.animation_finished
		ArgaliaAnimation.play("walk")
		current_look_dir = "left"
