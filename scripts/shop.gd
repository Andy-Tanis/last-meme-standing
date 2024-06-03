extends Node2D

@export var CoinScene: PackedScene

@onready var spawner_component: SpawnerComponent = $SpawnerComponent

var time_since_last_coin_spawn := 0

var margin = 400
var screen_height = ProjectSettings.get_setting("display/window/size/viewport_height")
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

var game_over := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$UI/ProgressBarWin.value = 50
	
	$RoundStart.play()
	
	$Intro/AnimationPlayer.play("show")
	
	$Boomer/AnimationPlayer.play("show")
	await get_tree().create_timer(.5).timeout
	$Karen/AnimationPlayer.play("show")

func _process(delta: float) -> void:
	
	if !game_over:
		
		if $UI/ProgressBarWin.value < 100 and $UI/ProgressBarWin.value > 0:
			
			$UI/ProgressBarWin.value -= 0.05
			
			if time_since_last_coin_spawn <= 0:
				spawn_coin()
				
				var rng = RandomNumberGenerator.new()
				rng.randomize()
				time_since_last_coin_spawn = rng.randi_range(10, 50)
				
			else:
				time_since_last_coin_spawn -= 1
				
		elif $UI/ProgressBarWin.value == 100:
			
			win()
			
		elif $UI/ProgressBarWin.value == 0:
			
			lose()

func spawn_coin() -> void:
	
	var new_node = spawner_component.spawn(Vector2(randf_range(margin, screen_width - margin), screen_height + 150))
	var is_karen = false
	if new_node.icon == 1 or new_node.icon == 2 or new_node.icon == 3:
		is_karen = true
		
	new_node.find_child("Button").pressed.connect(update_progress_win_bar.bind(new_node, new_node.get("scale").x, is_karen))
	
	
func update_progress_win_bar(new_node, scale, character) -> void:
	$Camera2D.apply_shake()
	var coin_value:float = 1 - scale
	coin_value *= 20
	var formatted_coin_value: int = int(coin_value)
	
	if character == false:
		new_node.find_child("Score").text = "+" + str(formatted_coin_value)
		$UI/ProgressBarWin.value += formatted_coin_value
	else:
		new_node.find_child("Score").text = "-" + str(formatted_coin_value)
		$UI/ProgressBarWin.value -= formatted_coin_value
		
	new_node.find_child("Score").add_theme_font_size_override("font_size", formatted_coin_value * 30)
	new_node.find_child("Score").show()
	
func win() -> void:
	
	game_over = true
	Global.karen_wins += 1
	get_tree().call_group("coin", "speed_up")
	$LabelYouWinLose.text = "You Won!"
	$LabelYouWinLose/AnimationPlayer.play("show")
	$Boomer/AnimationPlayer.play("lose")
	$Karen/AnimationPlayer.play("win")
	$Win.play()
	
	await $LabelYouWinLose/AnimationPlayer.animation_finished
	
	get_tree().change_scene_to_file("res://scenes/select.tscn")
	
func lose() -> void:
	
	game_over = true
	get_tree().call_group("coin", "speed_up")
	$LabelYouWinLose.text = "You Lost!"
	$LabelYouWinLose/AnimationPlayer.play("show")
	$Boomer/AnimationPlayer.play("win")
	$Karen/AnimationPlayer.play("lose")
	$Lose.play()
	
	await $LabelYouWinLose/AnimationPlayer.animation_finished
	
	get_tree().change_scene_to_file("res://scenes/select.tscn")
