extends TextureButton

var level: int = 1
var is_unlocked: bool = false

func _ready() -> void:
	level = get_index()+1
	is_unlocked = level <= Levelmanager.level_unlocked
	modulate.a = 1.0 if is_unlocked else 0.5

func _pressed() -> void:
	$MenuSound.play()
	await $MenuSound.finished
	if is_unlocked:
		Levelmanager.current_level = level
		get_tree().call_deferred("change_scene_to_file", Levelmanager._load_level(level))
	

func _on_back_button_pressed() -> void:
	$MenuSound.play()
	await $MenuSound.finished
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
