extends Node


onready var plain = preload("res://Scenes/Plain.tscn")
onready var cactus = preload("res://Scenes/Cactus.tscn")
onready var grave = preload("res://Scenes/Grave.tscn")
onready var player = preload("res://Scenes/Player.tscn")
onready var torch = preload("res://Scenes/Torch.tscn")
onready var mob_horse = preload("res://Scenes/Mob_horse.tscn")
onready var lamp_post = preload("res://Scenes/LampPost.tscn")
onready var mob_commoner = preload("res://Scenes/Mob_commoner.tscn")

var torches_collected = 0
var tiles = ["plain", "plain", "plain", "plain","plain","plain","plain","plain","plain","plain","plain","plain","plain","plain","plain","plain","plain","plain","plain","plain","plain", "cactus","cactus", "grave"]
var buffer = 7
var sheeps = 0
var game_over = false
var win = false

#position variables : 
var x = 0
var y = 0

#world node
var undead = 0
var commoners = 0

var p_spawner
var player_spawned = true

var ll = 0
var ul = 1280

var enemies = []

func death():
	
	var rnd = RandomNumberGenerator.new()
	rnd.randomize()
	for n in enemies:
		n.queue_free()
	
	enemies.clear()
	
	var cmr = mob_commoner.instance()
	var _x = rnd.randi_range(ll, ul)
	var _y = rnd.randi_range(ll, ul)
	
	var _xcor = (_x - x%64)
	var _ycor = (_y - y%64)
	call_deferred("add_child", cmr)
	cmr.position = Vector2(_xcor, _ycor)
	sheeps += 1

	
	for l in range(rnd.randi_range(1, 4)):
		
		randomize()
		rnd.randomize()
		var x = rnd.randi_range(ll, ul)
		var y = rnd.randi_range(ll, ul)
		
		var xcor = (x - x%64)
		var ycor = (y - y%64)
		

		var mbh = mob_horse.instance()
		enemies.append(mbh)
		call_deferred("add_child", mbh)
		mbh.position = Vector2(xcor, ycor)
	
	

func _ready():

	#we will add a map generation algorithm here, using the for loop:
	#we have 3 types of cards to place and they will be placed randomly 
	#this is to avoid any much much
	for i in range(20):
		for j in range(20):
			var random = RandomNumberGenerator.new()
			random.randomize()
			
			randomize()
			
			var cur_block = tiles[randi()%tiles.size()]
			 
			#check which block is going to be placed : 
			if cur_block == "plain":
				var pln = plain.instance()
				add_child(pln)
				pln.position = Vector2(x, y)

				if player_spawned == true:
					var ran = RandomNumberGenerator.new()
					ran.randomize()
					var k = ran.randi_range(0, 500)

					
					if k < 5:
						var lp = lamp_post.instance()
						add_child(lp)
						lp.position = Vector2(x, y)
						

				
			if cur_block == "cactus":
				var cac = cactus.instance()
				add_child(cac)
				cac.position = Vector2(x,y)
	

			if cur_block == "grave":
				var grv = grave.instance()
				add_child(grv)
				grv.position = Vector2(x,y)
	
				
			x += 64

		y += 64
		x = 0
		
	var rand = RandomNumberGenerator.new()
	rand.randomize()

	for l in range(rand.randi_range(1, 4)):
		
		randomize()
		var x = rand.randi_range(ll, ul)
		var y = rand.randi_range(ll, ul)
		
		var xcor = (x - x%64)
		var ycor = (y - y%64)
		

		var mbh = mob_horse.instance()
		enemies.append(mbh)
		add_child(mbh)
		mbh.position = Vector2(xcor, ycor)

		
	for c in range(21):
		randomize()
		var x = rand.randi_range(ll, ul)
		var y = rand.randi_range(ll, ul)
		
		var xcor = (x - x%64)
		var ycor = (y - y%64)
		var tor = torch.instance()
		add_child(tor)
		tor.position = Vector2(xcor,ycor)
	
	var ply = player.instance()
	add_child(ply)
	ply.position = Vector2(-64, -64)

func _process(delta):
	$CanvasLayer/TorchLabel2.text = str(torches_collected)
	$CanvasLayer/BufferLabel2.text = str(buffer)
	$CanvasLayer/SheepLabel2.text = str(sheeps)
	
	if buffer <= 0:
		print("game over")
		$CanvasLayer/Label.visible = true
		game_over = true
		$Timer.start(4)
		$AudioStreamPlayer.playing = false
		$AudioStreamPlayer3.playing = true
		set_process(false)
	
	
	if torches_collected >= 14:
		$CanvasLayer/Label2.visible = true
		win = true
		$Timer.start(4)
		$AudioStreamPlayer.playing = false
		$AudioStreamPlayer2.playing = true
		set_process(false)
	


func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_StartTimer_timeout():
	$AudioStreamPlayer.playing = true
