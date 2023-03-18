extends KinematicBody2D

export (int) var speed = 300

var paddle_size = Vector2(14, 100)
var dist_from_edge = 25
var start_position = Vector2(25, 212.5)
var screen_size
var velocity = Vector2()
var in_game = false

func _ready():
	hide()
	screen_size = get_viewport_rect().size
	position = start_position

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("move_up_paddle1"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down_paddle1"):
		velocity.y += 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	if in_game:
		get_input()
		move_and_slide(velocity)
		position.x = dist_from_edge
		position.y = clamp(position.y, 0, screen_size.y - paddle_size.y)
	else:
		hide()


func _on_Main_start_game():
	_ready()
	show()
	in_game = true


func _on_Main_game_won(paddle_num):
	hide()
	in_game = false
