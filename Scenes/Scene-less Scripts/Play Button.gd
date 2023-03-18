extends Button

var in_game = false

func _ready():
	show()

func _process(delta):
	if !in_game:
		show()
	else:
		hide()


func _on_Main_start_game():
	in_game = true
	hide()
