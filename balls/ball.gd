## Represents a ball that moves and reacts to collisions.
##
## This class extends [CharacterBody2D] and handles movement based on its rotation,
## gravity, and collision reactions. When the ball exits the screen or its health reaches zero, it is removed from the scene.

extends CharacterBody2D
class_name Ball

## The speed at which the ball moves.
##
## This value determines how fast the ball moves based on its rotation. A higher value means the ball will move faster.
@export var speed : float = 500

## The health component of the ball.
##
## This variable holds the ball's health, and when it reaches zero, the ball will be removed from the scene.
@onready var _health : Health = $Health as Health

## The notifier that tracks whether the ball is on the screen.
##
## This component notifies when the ball exits the screen, triggering the ball's death.
@onready var _visible_on_screen_notifier_2D : VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D as VisibleOnScreenNotifier2D

## Called when the node enters the scene tree.
##
## Initializes the ball's movement based on its rotation and speed, and connects signals for death and screen exit.
func _ready() -> void:
	_visible_on_screen_notifier_2D.screen_exited.connect(_on_death)  # Connects the exit screen signal to the _on_death function
	_health.died.connect(queue_free)  # Connects the health's died signal to remove the ball from the scene
	velocity = Vector2.from_angle(rotation) * speed  # Sets the ball's initial velocity based on its rotation

## Updates the ball's position and handles collisions.
##
## Applies gravity to the velocity and checks for collisions. If a collision occurs,
## the ball's velocity is adjusted using the normal of the collision surface to simulate a bounce.
##
## [param delta]: The frame time step used for movement.
func _physics_process(delta) -> void:
	velocity += get_gravity()  # Apply gravity to the ball's velocity
	
	# Check for collisions and handle the bounce if any occur
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		if collision_info.get_collider() is Paddle:
			return
		
		var normal = collision_info.get_normal()  # Get the collision normal
		velocity = velocity.bounce(normal)  # Bounce the velocity off the surface

## Called when the ball exits the screen.
##
## This function is triggered by the screen exit notifier and removes the ball from the scene.
func _on_death() -> void:
	queue_free()  # Removes the ball from the scene
