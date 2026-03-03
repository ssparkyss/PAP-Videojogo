extends Node2D

var level: int = 1

func _ready() -> void:
	$MusicPlayerLVL3.play()
	
func _on_argalia_inimigo_tree_exited() -> void:
	$Morte.play()
	$LevelFinishOrb/AnimationPlayer.play("spinning_essence")
	$LevelFinishOrb.visible = true

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(str("res://scenes/levelselect.tscn"))
