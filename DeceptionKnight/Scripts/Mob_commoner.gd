extends KinematicBody2D



var tile_size = 64
var key 
var smoothing = 300
var ll = 433
var ul = 832
var deceptor = false
var steps = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func move(delta):
	randomize()
	
	var r = RandomNumberGenerator.new()
	r.randomize()
	var n = r.randi_range(0, 1)

	var movlis = ["up", "down", "left", "right"]
	
	var random_move = movlis[randi()%movlis.size()]
	
	if random_move == "up":
		var pos = self.global_position
		var target = pos + Vector2(0, -tile_size * n)
		if target.y > ll:
			position = pos.linear_interpolate(target, delta * smoothing)
	
	if random_move == "down":
		var pos = self.global_position
		var target = pos + Vector2(0, tile_size * n)
		if target.y < ul:
			position = pos.linear_interpolate(target, delta * smoothing)
	
	if random_move == "left":
		$Sprite.flip_h = false
		var pos = self.global_position
		var target = pos + Vector2(-tile_size * n, 0)
		if target.x > ll:
			position = pos.linear_interpolate(target, delta * smoothing)
	
	if random_move == "right":
		$Sprite.flip_h = true
		var pos = self.global_position
		var target = pos + Vector2(tile_size * n, 0)
		if target.x < ul:
			position = pos.linear_interpolate(target, delta * smoothing)

func _physics_process(delta):



	
	if Input.is_action_just_pressed("up"):
		move(delta)
	if Input.is_action_just_pressed("down"):
		move(delta)
	if Input.is_action_just_pressed("left"):
		move(delta)
	if Input.is_action_just_pressed("right"):
		move(delta)
	




func _on_Area2D_area_entered(area):
	if area.is_in_group("torch"):
		area.queue_free()
		get_parent().buffer -= 1
		print("gottem")
