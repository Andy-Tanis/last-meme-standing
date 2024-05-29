extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_mow_1_pressed() -> void:
	
	lawnmower_spawned()
	
	$Lawnmower.position = Vector2(240, 270)
	
	$Lawnmower.show()
	
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Lawnmower, "position", Vector2(2200, 270), 2.5)
	tween.tween_callback(finished_mowing)
	
func lawnmower_spawned() -> void:
	
	$AudioLawnmower.play()
	
	$ButtonMow1.hide()
	$ButtonMow2.hide()
	$ButtonMow3.hide()

func _on_button_mow_2_pressed() -> void:
	
	lawnmower_spawned()
	
	$Lawnmower.position = Vector2(240, 570)
	
	$Lawnmower.show()
	
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Lawnmower, "position", Vector2(2200, 570), 2.5)
	tween.tween_callback(finished_mowing)
	
func _on_button_mow_3_pressed() -> void:
	
	lawnmower_spawned()
	
	$Lawnmower.position = Vector2(240, 840)
	
	$Lawnmower.show()
	
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property($Lawnmower, "position", Vector2(2200, 840), 2.5)
	tween.tween_callback(finished_mowing)

func finished_mowing() -> void:
	
	$Lawnmower.hide()
	
	$ButtonMow1.show()
	$ButtonMow2.show()
	$ButtonMow3.show()
