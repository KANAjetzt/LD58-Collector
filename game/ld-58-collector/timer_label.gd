extends Label
func _ready():
	set_process(true)
	
func _process(_delta: float) -> void:
	text = _format_time($Timer.time_left)

func _format_time(seconds: float) -> String:
	if seconds <= 0.0:
		return "00:00"

	var s := int(ceil(seconds))
	var m := s / 60
	var r := s % 60
	return "%02d:%02d" % [m, r]
