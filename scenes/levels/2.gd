extends Node2D

var level: int = 1

func _on_kim_inimigo_tree_exited() -> void:
	$Morte.play()
	$LevelFinishOrb.visible = true
