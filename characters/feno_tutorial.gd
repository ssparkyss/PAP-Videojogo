extends CharacterBody2D

var health: float = 10

func _ready() -> void:
	add_to_group("enemy")

func _on_feno_hurtbox_area_entered(_area: Area2D) -> void:
	$FenoSprite/FenoAnimation.play("take_damage")
	$HitSound.play()
	health -= 1
	if health <= 0.0:
		queue_free()
