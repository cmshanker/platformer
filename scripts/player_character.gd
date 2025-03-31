extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

var jumps_remaining = 1
var dead = false

func _physics_process(delta: float) -> void:
	
	# Don't apply physics to dead player
	if dead:
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif jumps_remaining > 0:
			jumps_remaining -= 1
			velocity.y = JUMP_VELOCITY
	if is_on_floor():
		jumps_remaining = 1

	# direction will be -1 when moving left, 1 when moving right
	# and 0 when neither left or right is changing
	var direction := Input.get_axis("move_left", "move_right")
	
	# Change direction the player is facing
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func die() -> void:
	dead = true
	Engine.time_scale = 0.5
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D, "modulate", Color.RED, 1).set_trans(Tween.TRANS_SINE)
	tween.tween_property($AnimatedSprite2D, "scale", Vector2(), 1).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_callback($AnimatedSprite2D.queue_free)
	tween.bind_node(self)
	timer.start()

func _on_hit_box_body_entered(_body: Node2D) -> void:
	die()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	dead = false
