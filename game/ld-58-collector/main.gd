extends Node


@onready var timer: Timer = %Timer
@onready var animation_player: AnimationPlayer = %AnimationPlayer


func _ready() -> void:
	Global.game_over.connect(end_game)


func end_game(is_win: bool) -> void:
	timer.stop()

	$CanvasLayer/TimerLabel.visible = false
	$CanvasLayer/AnimatedEnd.visible = true

	animation_player.play(&"fade_in")
	await animation_player.animation_finished

	if is_win:
		$CanvasLayer/AnimatedEnd.play("win")
	else:
		$CanvasLayer/AnimatedEnd.play("lose")

	await $CanvasLayer/AnimatedEnd.animation_finished

	animation_player.play(&"fade_in_label")


func _on_timer_timeout() -> void:
	Global.end_game(false)
