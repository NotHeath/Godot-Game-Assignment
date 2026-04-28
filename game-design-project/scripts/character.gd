# update: removed jump, added sprite frames for idle and walking

extends CharacterBody2D

# Movement speed in pixels per second
const SPEED = 100.0

# Get the AnimatedSprite2D node
@onready var sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Get input direction (-1 = left, 0 = none, 1 = right)
	var direction = Input.get_axis("ui_left", "ui_right")

	# Move the character
	if direction != 0:
		velocity.x = direction * SPEED
		# Play run animation
		sprite.play("walking")
		# Flip sprite to face the direction of movement
		sprite.flip_h = direction < 0
	else:
		# No input — slow down and play idle
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.play("idle")

	move_and_slide()
