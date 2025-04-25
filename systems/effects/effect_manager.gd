#class_name EffectManager - Autoload
extends Node


func create_and_play_audio(audio : AudioStreamWrapper) -> void:
	var audio_player = AudioStreamPlayer.new()
	audio_player.stream = audio.stream
	audio_player.volume_db = audio.volume_db
	audio_player.pitch_scale = audio.pitch_scale
	
	audio_player.finished.connect(audio_player.queue_free)
	
	add_child(audio_player)
	audio_player.play()
	

func create_and_play_animatable_sprite(sprite : SpriteFrames, anim_name : String, sprite_position : Vector2, _z_index : int = 0) -> void:
	var animatable_sprite = AnimatedSprite2D.new()
	animatable_sprite.sprite_frames = sprite
	animatable_sprite.position = sprite_position
	animatable_sprite.z_index = _z_index
	
	animatable_sprite.animation_finished.connect(animatable_sprite.queue_free)
	
	add_child(animatable_sprite)
	animatable_sprite.play(anim_name)
