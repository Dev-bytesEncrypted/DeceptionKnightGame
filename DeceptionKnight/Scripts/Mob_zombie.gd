extends KinematicBody2D



var tile_size = 64
var key = ["up", "down", "left", "right"]
var smoothing = 300
var ll = 433
var ul = 832


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func _physics_process(delta):
	
	var r = RandomNumberGenerator.new()
	r.randomize()
	var n = r.randi_range(1, 4)
	
	if Input.is_action_just_pressed("up"):
		key = "up"
		var pos = self.global_position
		var target = pos + Vector2(0, tile_size * n)
		if target.y < ul:
			position = pos.linear_interpolate(target, delta * smoothing)

	if Input.is_action_just_pressed("down"):
		key = "down"
		var pos = self.global_position
		var target = pos + Vector2(0, -tile_size * n)
		if target.y > ll:
			position = pos.linear_interpolate(target, delta * smoothing)

				
	if Input.is_action_just_pressed("left"):
		key = "left"
		$Sprite.flip_h = false
		var pos = self.global_position
		var target = pos + Vector2(tile_size * n, 0)
		if target.x < ul:
			position = pos.linear_interpolate(target, delta * smoothing)

	
	if Input.is_action_just_pressed("right"):
		key = "right"
		$Sprite.flip_h = true
		var pos = self.global_position
		var target = pos + Vector2(-tile_size * n, 0)
		if target.x > ll:
			position = pos.linear_interpolate(target, delta * smoothing)
