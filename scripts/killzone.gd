extends Area2D

signal player_die

func _on_body_entered(_body: Node2D) -> void:
	player_die.emit()
