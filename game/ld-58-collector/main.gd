extends Node


func _on_timer_timeout() -> void:
	$CanvasLayer/TimerLabel.visible = false
	$CanvasLayer/AnimatedEnd.visible = true
	$CanvasLayer/AnimatedEnd.play("lose")

func _on_win() -> void:
	$CanvasLayer/TimerLabel.visible = false
	$CanvasLayer/AnimatedEnd.visible = true
	$CanvasLayer/AnimatedEnd.play("win")
