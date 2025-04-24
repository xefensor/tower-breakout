#class_name AudioManager - Autoload
extends Node


func create_and_play_audio(audio : AudioStreamWrapper):
	var audio_player = AudioStreamPlayer.new()
	audio_player.stream = audio.stream
	audio_player.volume_db = audio.volume_db
	audio_player.pitch_scale = audio.pitch_scale
	
	audio_player.finished.connect(audio_player.queue_free)
	
	add_child(audio_player)
	audio_player.play()
	
