extends Area2D

var was_hit = false


func _ready() -> void:
	Global.pelets += 1

func _on_body_entered(body: Node2D) -> void:
	if was_hit: return 
	
	was_hit = true
	$AudioStreamPlayer2D.play()
	
	self.hide()
	


func _on_audio_stream_player_2d_finished() -> void:
	if was_hit: self.queue_free()
