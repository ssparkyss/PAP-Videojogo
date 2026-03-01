extends Node2D

func _on_back_button_pressed() -> void:
	$MenuSound.play()
	await $MenuSound.finished
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
