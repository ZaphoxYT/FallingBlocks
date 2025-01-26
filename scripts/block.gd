class_name Block extends Sprite2D

signal block_freed

func _exit_tree() -> void:
	block_freed.emit()
