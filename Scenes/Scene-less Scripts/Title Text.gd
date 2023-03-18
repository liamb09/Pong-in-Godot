extends RichTextLabel

var in_game = false

func _ready():
	show()
	rect_position = Vector2(349, 140)

func _process(delta):
	if !in_game:
		show()
	else:
		hide()


func _on_Main_start_game():
	in_game = true
	hide()

func _on_Main_game_won(paddle_num):
	in_game = false
	rect_position = Vector2(147, 140)
	if paddle_num == 1:
		text = "Player 1 Wins!"
	else:
		text = "Player 2 Wins!"
