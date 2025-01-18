class_name Piece
extends Node2D

const BLOCK_SIZE = 32
const PALLETE = preload("res://assets/sprites/pallete.png")
const SHAPES = {
	"I": [Vector2(-1, 0), Vector2(0, 0), Vector2(1, 0), Vector2(2, 0)],
	"O": [Vector2(0, 0), Vector2(1, 0), Vector2(0, 1), Vector2(1, 1)],
	"T": [Vector2(-1, 0), Vector2(0, 0), Vector2(1, 0), Vector2(0, 1)],
	"L": [Vector2(-1, 0), Vector2(0, 0), Vector2(1, 0), Vector2(1, 1)],
	"J": [Vector2(-1, 1), Vector2(-1, 0), Vector2(0, 0), Vector2(1, 0)],
	"S": [Vector2(0, 0), Vector2(1, 0), Vector2(-1, 1), Vector2(0, 1)],
	"Z": [Vector2(-1, 0), Vector2(0, 0), Vector2(0, 1), Vector2(1, 1)]
}

const COLORS = {
	"I": 0,
	"O": 1,
	"T": 2,
	"L": 3,
	"J": 4,
	"S": 5,
	"Z": 6
}

var blocks: Array[Sprite2D] = []
var my_shape: String = ""
var speed: float = 1.0  # Speed of automatic falling
var fall_timer: float = 0.0  # Timer to track automatic falling

func initialize(shape_name: String):
	for block in blocks:
		block.queue_free()
	blocks.clear()

	if not SHAPES.has(shape_name):
		print("Invalid shape name:", shape_name)
		return

	my_shape = shape_name

	for pos in SHAPES[shape_name]:
		var block = Sprite2D.new()
		block.texture = PALLETE
		block.region_enabled = true
		block.region_rect = Rect2(COLORS[shape_name] * BLOCK_SIZE, 0, BLOCK_SIZE, BLOCK_SIZE)
		block.position = pos * BLOCK_SIZE
		add_child(block)
		blocks.append(block)

func rotate_piece():
	if my_shape == "O":
		return
	for block in blocks:
		var new_position = Vector2(-block.position.y / BLOCK_SIZE, block.position.x / BLOCK_SIZE)
		block.position = new_position * BLOCK_SIZE

func move_left():
	for block in blocks:
		block.position.x -= BLOCK_SIZE

func move_right():
	for block in blocks:
		block.position.x += BLOCK_SIZE

func fall(delta: float):
	fall_timer += delta
	if fall_timer >= speed:
		for block in blocks:
			block.position.y += BLOCK_SIZE
		fall_timer = 0.0

func _ready():
	# for testing
	initialize("O")
	position = Vector2(200,50)

func _process(delta):
	if Input.is_action_just_pressed("rotate_piece"):
		rotate_piece()

	if Input.is_action_just_pressed("ui_left"):
		move_left()

	if Input.is_action_just_pressed("ui_right"):
		move_right()

	if Input.is_action_pressed("ui_down"):
		speed = 0.5
	else:
		speed = 1.0

	# Handle automatic falling
	fall(delta)
