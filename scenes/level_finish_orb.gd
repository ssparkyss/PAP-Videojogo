extends Node2D

func _on_area_2d_area_entered(_area: Area2D) -> void:
	$OrbSound.play()
	await $OrbSound.finished
	Levelmanager.current_level += 1
	Levelmanager._unlock_level(Levelmanager.current_level)
	var level_to_load: String = Levelmanager._load_level(Levelmanager.current_level)
	if level_to_load == "":
		return
	get_tree().call_deferred("change_scene_to_file", level_to_load)
