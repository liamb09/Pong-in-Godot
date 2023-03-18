extends Node
signal start_game()
signal game_won(paddle_num)
signal serve_to(me)

var paddle1score = 0
var paddle2score = 0
var winning_score = 4

func _ready():
	paddle1score = 0
	paddle2score = 0
	$Paddle1Score.bbcode_text = "[right]0"
	$Paddle2Score.bbcode_text = "0"
	$Text.text = "Pong"

func _process(delta):
	pass

func update_scores():
	$Paddle1Score.bbcode_text = "[right]" + str(paddle1score)
	$Paddle2Score.bbcode_text = str(paddle2score)
	
func _on_Ball_point(paddle_num):
	if paddle_num == 1:
		paddle1score += 1
		emit_signal("serve_to", 2)
	else:
		paddle2score += 1
		emit_signal("serve_to", 1)
	print(paddle1score)
	update_scores()
	if paddle1score < winning_score && paddle2score < winning_score:
		emit_signal("start_game")
	else:
		if paddle1score == winning_score:
			emit_signal("game_won", 1)
		else:
			emit_signal("game_won", 2)


func _on_Play_Button_pressed():
	emit_signal("start_game")
