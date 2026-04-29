# update: removed jump, added sprite frames for idle and walking

extends CharacterBody2D

# Movement speed in pixels per second
const SPEED = 100.0

# Get the AnimatedSprite2D node
@onready var sprite = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	var direction = Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = direction * SPEED
		sprite.play("walking") # Plays the animation
		sprite.flip_h = direction < 0
		Global.is_moving = true # Flagging the movement booolean
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		sprite.play("idle")
		Global.is_moving = false # Stop the music!

	move_and_slide()
