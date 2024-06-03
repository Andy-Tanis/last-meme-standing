extends Node2D

var screen_height = ProjectSettings.get_setting("display/window/size/viewport_height")

@onready var spawner_component_lawnmower: SpawnerComponent = $SpawnerComponentLawnmower
@onready var spawner_component_cloud: SpawnerComponent = $SpawnerComponentCloud
@onready var spawner_component_call_police: SpawnerComponent = $SpawnerComponentCallPolice
@onready var spawner_component_police: SpawnerComponent = $SpawnerComponentPolice
@onready var spawner_component_barbell: SpawnerComponent = $SpawnerComponentBarbell
@onready var spawner_component_armcurl: SpawnerComponent = $SpawnerComponentArmcurl

var time_since_last_lawnmower_spawn := 0
var time_since_last_cloud_spawn := 0
var time_since_last_call_police_spawn := 0
var time_since_last_police_spawn := 0
var time_since_last_barbell_spawn := 0
var time_since_last_armcurl_spawn := 0

var game_won := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if Global.boomer_wins >= 1:
		$BoomerTrophies/Trophy1.texture = load("res://assets/select/trophy.webp")
	if Global.boomer_wins >= 2:
		$BoomerTrophies/Trophy2.texture = load("res://assets/select/trophy.webp")
	if Global.boomer_wins >= 3:
		$BoomerTrophies/Trophy3.texture = load("res://assets/select/trophy.webp")
		
	if Global.karen_wins >= 1:
		$KarenTrophies/Trophy1.texture = load("res://assets/select/trophy.webp")
	if Global.karen_wins >= 2:
		$KarenTrophies/Trophy2.texture = load("res://assets/select/trophy.webp")
	if Global.karen_wins >= 3:
		$KarenTrophies/Trophy3.texture = load("res://assets/select/trophy.webp")
		
	if Global.gigachad_wins >= 1:
		$GigachadTrophies/Trophy1.texture = load("res://assets/select/trophy.webp")
	if Global.gigachad_wins >= 2:
		$GigachadTrophies/Trophy2.texture = load("res://assets/select/trophy.webp")
	if Global.gigachad_wins >= 3:
		$GigachadTrophies/Trophy3.texture = load("res://assets/select/trophy.webp")
	
	$AnimationPlayer.play("show")
	
	if Global.boomer_wins == 3:
		game_won = true
		$BoomerWins.text = "Boomer"
		await $AnimationPlayer.animation_finished
		$AnimationPlayer.play("boomer_wins")
		await $AnimationPlayer.animation_finished
		$ReplayButton.show()
	elif Global.karen_wins == 3:
		game_won = true
		$BoomerWins.text = "Karen"
		await $AnimationPlayer.animation_finished
		$AnimationPlayer.play("karen_wins")
		await $AnimationPlayer.animation_finished
		$ReplayButton.show()
	elif Global.gigachad_wins == 3:
		game_won = true
		$BoomerWins.text = "Gigachad"
		await $AnimationPlayer.animation_finished
		$AnimationPlayer.play("gigachad_wins")
		await $AnimationPlayer.animation_finished
		$ReplayButton.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if !game_won:
		if time_since_last_lawnmower_spawn <= 0:
			spawn_lawnmower()
			
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			time_since_last_lawnmower_spawn = rng.randi_range(400, 600)
			
		else:
			time_since_last_lawnmower_spawn -= 1
			
		if time_since_last_cloud_spawn <= 0:
			spawn_cloud()
			
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			time_since_last_cloud_spawn = rng.randi_range(400, 600)
			
		else:
			time_since_last_cloud_spawn -= 1
			
		if time_since_last_call_police_spawn <= 0:
			spawn_call_police()
			
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			time_since_last_call_police_spawn = rng.randi_range(400, 600)
			
		else:
			time_since_last_call_police_spawn -= 1
			
		if time_since_last_police_spawn <= 0:
			spawn_police()
			
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			time_since_last_police_spawn = rng.randi_range(400, 600)
			
		else:
			time_since_last_police_spawn -= 1
			
		if time_since_last_barbell_spawn <= 0:
			spawn_barbell()
			
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			time_since_last_barbell_spawn = rng.randi_range(400, 600)
			
		else:
			time_since_last_barbell_spawn -= 1
			
		if time_since_last_armcurl_spawn <= 0:
			spawn_armcurl()
			
			var rng = RandomNumberGenerator.new()
			rng.randomize()
			time_since_last_armcurl_spawn = rng.randi_range(400, 600)
			
		else:
			time_since_last_armcurl_spawn -= 1
		
func spawn_lawnmower() -> void:
	
	var new_node = spawner_component_lawnmower.spawn(Vector2(randf_range(100, 500), -150))
	
func spawn_cloud() -> void:
	
	var new_node = spawner_component_cloud.spawn(Vector2(randf_range(100, 500), -150))
	
func spawn_call_police() -> void:
	
	var new_node = spawner_component_call_police.spawn(Vector2(randf_range(700, 1100), -150))
	
func spawn_police() -> void:
	
	var new_node = spawner_component_police.spawn(Vector2(randf_range(700, 1100), -150))
	
func spawn_barbell() -> void:
	
	var new_node = spawner_component_barbell.spawn(Vector2(randf_range(1400, 1900), -150))
	
func spawn_armcurl() -> void:
	
	var new_node = spawner_component_armcurl.spawn(Vector2(randf_range(1400, 1900), -150))


func _on_boomer_pressed() -> void:
	
	get_tree().change_scene_to_file("res://scenes/lawn.tscn")


func _on_karen_pressed() -> void:
	
	get_tree().change_scene_to_file("res://scenes/shop.tscn")


func _on_gigachad_pressed() -> void:
	
	get_tree().change_scene_to_file("res://scenes/gigachad.tscn")


func _on_replay_button_pressed() -> void:
	
	Global.boomer_wins = 0
	Global.karen_wins = 0
	Global.gigachad_wins = 0
	
	get_tree().change_scene_to_file("res://scenes/select.tscn")
