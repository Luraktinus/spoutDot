extends Camera2D

onready var player = $"../Player"


func _physics_process(delta):
	var py = player.position.y
	var cy = position.y
	delta = cy - py
	var s_delta = sqrt(abs(delta)) * delta / (abs(delta)+0.000001)
	var new_pos = position.y - s_delta * .7
	#if new_pos < position.y:
	position.y = new_pos
	# position.y = player.position.y
	# position.x = player.position.x
