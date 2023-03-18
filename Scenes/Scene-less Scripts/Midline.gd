extends Sprite

var in_game = false

func _ready():
	hide()

func _process(delta):
	if in_game:
		show()
	else:
		hide()

func _on_Main_start_game():
	in_game = true
	show()


func _on_Main_game_won(paddle_num):
	hide()
	in_game = false
