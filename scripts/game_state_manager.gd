extends Node

@onready var player_character: CharacterBody2D = %PlayerCharacter
@onready var killzone: Area2D = %Killzone
@onready var flagpole: Node2D = %Flagpole

func _ready() -> void:
	killzone.player_die.connect(on_player_die)
	flagpole.player_win.connect(on_player_win)
	
func on_player_die() -> void:
	player_character.die()

func on_player_win() -> void:
	print('yayayay')
