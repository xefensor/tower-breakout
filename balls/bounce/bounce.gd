class_name Bounce
extends Resource


var ball: Ball
var audio_player: OneShotAudioPlayer


func bounce(collision_info: KinematicCollision2D):
	audio_player.one_shot_play(Level.instance)
		
	var normal: Vector2 = collision_info.get_normal()
	ball.velocity = ball.velocity.bounce(normal) + collision_info.get_collider_velocity()*0.5
