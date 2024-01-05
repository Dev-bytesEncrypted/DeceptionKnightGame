extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("startscreenknight")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Spikes_body_entered(body):
	$Spikes/AudioStreamPlayer2D.playing = true
	body.position = Vector2(0, 0)


func _on_TutorialFinish_body_entered(body):
	$Timer.start(0.75)
	$AudioStreamPlayer.playing = false
	
func _on_Torches_body_entered(body):
	$SampleSprites/Sprite24.visible = false
	$Torches/AudioStreamPlayer2D.playing = true


func _on_Timer_timeout():
	
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_Starttm_timeout():
	$AudioStreamPlayer.playing = true
