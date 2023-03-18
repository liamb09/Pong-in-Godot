extends KinematicBody2D
signal point(paddle_num)

export (int) var speed

var ball_size = Vector2(14, 14)
var velocity = Vector2.ZERO
var rng = RandomNumberGenerator.new()
var screen_size
var in_game = false
var rotation_dir
var serve_to = [-1, 1][randi() % 2]

func _ready():
	screen_size = get_viewport_rect().size
	speed = 600
	rng.randomize()
	if serve_to == 1:
		rotation_dir = rng.randf_range(PI*0.6, PI) * [-1, 1][randi() % 2]
	else:
		rotation_dir = rng.randf_range(-PI*0.4, PI*0.4)
	position = Vector2(422, 155.5)
	velocity.x = cos(rotation_dir)
	velocity.y = sin(rotation_dir)

func _physics_process(delta):
	if in_game:
		show()
		var collision_object = move_and_collide(velocity * speed * delta)
		if collision_object:
			velocity = velocity.normalized().bounce(collision_object.normal)
		position.x = clamp(position.x, 0, screen_size.x - ball_size.x)
		if position.x == 0:
			hide()
			velocity = Vector2()
			emit_signal("point", 2)
		elif position.x == screen_size.x - ball_size.x:
			hide()
			velocity = Vector2()
			emit_signal("point", 1)
	else:
		hide()


func _on_Main_start_game():
	show()
	in_game = true


func _on_Main_game_won(paddle_num):
	hide()
	in_game = false


func _on_Main_serve_to(me):
	serve_to = me
	_ready()
