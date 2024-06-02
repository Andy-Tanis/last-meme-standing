extends Node2D

@onready var spawner_component: SpawnerComponent = $SpawnerComponent

var time_since_last_icon_spawn := 0

var game_over := false

var screen_height = ProjectSettings.get_setting("display/window/size/viewport_height")

func _ready() -> void:
	
	$UI/ProgressBarWin.value = 50
	
	$RoundStart.play()
	
	$Gigachad/AnimationPlayer.play("show")
	await get_tree().create_timer(.5).timeout
	$Karen/AnimationPlayer.play("show")

func _process(delta: float) -> void:
	
	if !game_over:
		
		if $UI/ProgressBarWin.value < 100 and $UI/ProgressBarWin.value > 0:
			
			$UI/ProgressBarWin.value -= 0.06
			
			if time_since_last_icon_spawn <= 0:
				spawn_icon()
				
				var rng = RandomNumberGenerator.new()
				rng.randomize()
				time_since_last_icon_spawn = rng.randi_range(25, 60)
				
			else:
				time_since_last_icon_spawn -= 1
				
		elif $UI/ProgressBarWin.value == 100:
			
			win()
			
		elif $UI/ProgressBarWin.value == 0:
			
			lose()
			
func spawn_icon() -> void:
	
	var new_node = spawner_component.spawn(Vector2(900, -150))
	
func win() -> void:
	
	game_over = true
	$UI/Button.hide()
	get_tree().call_group("gym_icon", "speed_up")
	$LabelYouWinLose.text = "You Won!"
	$LabelYouWinLose/AnimationPlayer.play("show")
	$Gigachad/AnimationPlayer.play("win")
	$Karen/AnimationPlayer.play("lose")
	$Win.play()
	
	await $LabelYouWinLose/AnimationPlayer.animation_finished
	
	get_tree().change_scene_to_file("res://scenes/select.tscn")
	
func lose() -> void:
	
	game_over = true
	$UI/Button.hide()
	get_tree().call_group("gym_icon", "speed_up")
	$LabelYouWinLose.text = "You Lost!"
	$LabelYouWinLose/AnimationPlayer.play("show")
	$Gigachad/AnimationPlayer.play("lose")
	$Karen/AnimationPlayer.play("win")
	$Lose.play()
	
	await $LabelYouWinLose/AnimationPlayer.animation_finished
	
	get_tree().change_scene_to_file("res://scenes/select.tscn")


func _on_button_pressed() -> void:
	
	get_tree().call_group("gym_icon", "crush")
	
func gigachad_progress_increase() -> void:
	
	$UI/ProgressBarWin.value += 10
	
func gigachad_progress_decrease() -> void:
	
	$UI/ProgressBarWin.value -= 10
