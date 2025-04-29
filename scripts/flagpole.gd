extends Node2D

signal player_win
@onready var move: AnimationPlayer = $Flag/Sprite2D/Move

func _on_pole_body_entered(_body: Node2D) -> void:
	move.play('move')
	player_win.emit()
