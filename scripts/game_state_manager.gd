extends Node

@onready var player_character: CharacterBody2D = %PlayerCharacter
@onready var killzone: Area2D = %Killzone

func _ready() -> void:
	killzone.player_die.connect(on_player_die)
	
func on_player_die() -> void:
	player_character.die()
