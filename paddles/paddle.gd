## Represents a paddle that moves horizontally based on user input.
##
## This class extends [AnimatableBody2D] and handles horizontal movement for the paddle
## using input from the player. The paddle will move left or right based on the values 
## received from the input axis. 

extends AnimatableBody2D
class_name Paddle

## The speed at which the paddle moves.
##
## This value determines how fast the paddle moves horizontally. A higher value means 
## the paddle will move faster.
@export var speed : float = 5

## Updates the paddle's position based on user input.
##
## This function reads input from the player to determine the paddle's movement along the x-axis.
## The paddle's horizontal velocity is multiplied by the frame's delta time to make the movement frame-rate independent.
##
## [param delta]: The frame time step used for movement.
func _physics_process(delta: float) -> void:
	# Get horizontal input from the player
	var _direction = Input.get_axis("paddle_left", "paddle_right")
	
	# Set the velocity based on the direction input
	var _velocity = Vector2(_direction * speed, 0)
	
	# Pohybeme paddle a provádíme kolize
	var collision_info = move_and_collide(_velocity * delta)

	# Pokud dojde k nějaké kolizi, zkontrolujeme, jestli je to míč
	if collision_info:
		var collider = collision_info.get_collider()
		if collider is Ball:
			print("Brr")
			var ball = collider
			_on_ball_hit(ball, collision_info.get_position())
			
			
# Funkce pro zpracování kolize s míčem
func _on_ball_hit(ball: Ball, position: Vector2) -> void:
	# Určíme, kde míč narazil na paddle (vzdálenost od středu)
	var hit_position = position.x - global_position.x
	
	# Velikost paddle (pro přizpůsobení)
	var paddle_half_width = $Sprite2D.texture.get_width() * 0.2
	
	# Pokud narazí na levou nebo pravou část paddle
	if hit_position < -paddle_half_width: # Levá strana paddle
		ball.velocity = ball.velocity.reflect(Vector2(1, 0)) # Odrazíme se doprava
	elif hit_position > paddle_half_width: # Pravá strana paddle
		ball.velocity = ball.velocity.reflect(Vector2(-1, 0)) # Odrazíme se doleva
	else:  # Střední část paddle
		# Odrazíme míč vertikálně a zohledníme, jak daleko od středu paddle narazil
		var bounce_direction = Vector2(0, -1)
		# Čím dál od středu, tím více se změní úhel odrazu
		var distance_from_center = hit_position / paddle_half_width
		ball.velocity = ball.velocity.reflect(bounce_direction.rotated(distance_from_center * 45)) # Rotace úhlu odrazu
