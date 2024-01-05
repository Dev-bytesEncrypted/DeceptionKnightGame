extends KinematicBody2D


#our player will spawn into a plain tile and it will be selected by the world node
#our player will interpolate 64 pixels per turn
#the player can only move in 1 second timer delay.

#variables

var tile_size = 128
var smoothing = 30
var key
var ll = -128
var ul = 1344

var dead = false
var mob_dead = false

onready var signplate = preload("res://Scenes/Sign.tscn")

"""
var pos = self.global_position
var target = pos + Vector2(0, -tile_size)
position = pos.linear_interpolate(target, delta * smoothing)
"""
var init_pos
func _ready():
	init_pos = global_position
	
func explode():
	$Sprite2.visible = true
	$CPUParticles2D.emitting = true
	$Sprite.visible = false
	dead = true
	$Timer.start(2.5)

func _physics_process(delta):
	

	if dead == false:
		$Sprite2.visible = false
		$Sprite.visible = true
		if Input.is_action_just_pressed("up"):
			key = "up"
			var pos = self.global_position
			var target = pos + Vector2(0, -tile_size)
			if target.y > ll:
				position = pos.linear_interpolate(target, delta * smoothing)
	
		if Input.is_action_just_pressed("down"):
			key = "down"
			var pos = self.global_position
			var target = pos + Vector2(0, tile_size)
			if target.y < ul:
				position = pos.linear_interpolate(target, delta * smoothing)
	
					
		if Input.is_action_just_pressed("left"):
			key = "left"
			$Sprite.flip_h = false
			var pos = self.global_position
			var target = pos + Vector2(-tile_size, 0)
			if target.x > ll:
				position = pos.linear_interpolate(target, delta * smoothing)
		
		if Input.is_action_just_pressed("place"):
			var sgn = signplate.instance()
			get_parent().add_child(sgn)
			sgn.position = global_position
			$AudioStreamPlayer2D2.playing = true
		
		if Input.is_action_just_pressed("right"):
			key = "right"
			$Sprite.flip_h = true
			var pos = self.global_position
			var target = pos + Vector2(tile_size, 0)
			if target.x < ul:
				position = pos.linear_interpolate(target, delta * smoothing)


func _on_Area2D_area_entered(area):
	if area.is_in_group("torch"):
		$Light2D.texture_scale += 0.5
		area.queue_free()
		get_parent().torches_collected += 1
		$AudioStreamPlayer2D.playing = true


func _on_Timer_timeout():
	global_position = Vector2(-64, -64)
	dead = false

