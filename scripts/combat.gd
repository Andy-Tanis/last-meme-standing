extends Node2D

@export var CoinScene: PackedScene

@onready var spawner_component: SpawnerComponent = $SpawnerComponent

signal game_over_signal


var time_since_last_coin_spawn := 0

var margin = 400
var screen_height = ProjectSettings.get_setting("display/window/size/viewport_height")
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

var game_over := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	$UI/ProgressBarWin.value = 50
	$UI/ProgressBarLose.value = 50
	
	$RoundStart.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if !game_over:
		
		if $UI/ProgressBarWin.value < 100 and $UI/ProgressBarWin.value > 0:
			
			$UI/ProgressBarWin.value -= 0.05
			$UI/ProgressBarLose.value += 0.05
			
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
	var is_cloud = false
	if new_node.icon == 1:
		is_cloud = true
		
	new_node.find_child("Button").pressed.connect(update_progress_win_bar.bind(new_node.get("scale").x, is_cloud))
	
	
func update_progress_win_bar(coin_value, character) -> void:
	$Camera2D.apply_shake()
	if character == true:
		$UI/ProgressBarWin.value += coin_value * 15
		$UI/ProgressBarLose.value -= coin_value * 15
	else:
		$UI/ProgressBarWin.value -= coin_value * 20
		$UI/ProgressBarLose.value += coin_value * 20
	
func win() -> void:
	
	game_over = true
	game_over_signal.emit()
	get_tree().call_group("coin", "speed_up")
	$LabelYouWinLose.text = "You Won!"
	$LabelYouWinLose/AnimationPlayer.play("show")
	$Win.play()
	
func lose() -> void:
	
	game_over = true
	game_over_signal.emit()
	$LabelYouWinLose.text = "You Lost!"
	$LabelYouWinLose/AnimationPlayer.play("show")
	$Lose.play()
