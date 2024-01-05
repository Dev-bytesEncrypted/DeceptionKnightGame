extends Area2D


var immobile = false
var deceptive = false

func _ready():
	randomize()
	var r = ["true", "false", "false", "false", "false", "false", "false"]
	var q = r[randi()%r.size()]
	if q == "true":
		deceptive = true


func _on_Plain_body_entered(body):
	if body.is_in_group("player") and deceptive == true:
		$Spikes.visible = true
		body.explode()
		$Timer.start(1)
		get_parent().death()


func _on_Timer_timeout():
	$Spikes.visible = false


func _on_Area2D_body_entered(body):
	if deceptive == true:
		$AudioStreamPlayer2D.playing = true
