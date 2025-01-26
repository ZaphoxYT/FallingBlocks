class_name Piece
extends Node2D

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

const GENERAL_KICK_OFFSETS = [
	Vector2(0, 0),   # No offset
	Vector2(1, 0),   # Kick right
	Vector2(-1, 0),  # Kick left
	Vector2(0, 1),   # Kick down
	Vector2(0, -1)   # Kick up
]

const I_KICK_OFFSETS = {
	"clockwise": [
		[Vector2(0, 0), Vector2(-2, 0), Vector2(1, 0), Vector2(-2, -1), Vector2(1, 2)],
		[Vector2(0, 0), Vector2(-1, 0), Vector2(2, 0), Vector2(-1, 2), Vector2(2, -1)],
		[Vector2(0, 0), Vector2(2, 0), Vector2(-1, 0), Vector2(2, 1), Vector2(-1, -2)],
		[Vector2(0, 0), Vector2(1, 0), Vector2(-2, 0), Vector2(1, -2), Vector2(-2, 1)]
	],
	"counterclockwise": [
		[Vector2(0, 0), Vector2(-1, 0), Vector2(2, 0), Vector2(-1, 2), Vector2(2, -1)],
		[Vector2(0, 0), Vector2(2, 0), Vector2(-1, 0), Vector2(2, 1), Vector2(-1, -2)],
		[Vector2(0, 0), Vector2(1, 0), Vector2(-2, 0), Vector2(1, -2), Vector2(-2, 1)],
		[Vector2(0, 0), Vector2(-2, 0), Vector2(1, 0), Vector2(-2, -1), Vector2(1, 2)]
	]
}

const OFFSET = Vector2(16,16)
const BLOCK_SCENE = preload("res://scenes/block.tscn")
var blocks: Array[Sprite2D] = []
var piece_name: String = ""
var fall_timer: float = 0.0  # Timer to track automatic falling

func initialize(_shape_name: String):
	for block in blocks:
		block.queue_free()
	blocks.clear()

	if not SHAPES.has(_shape_name):
		push_error("Invalid shape name:", _shape_name)
		assert(false)

	piece_name = _shape_name

	for pos in SHAPES[_shape_name]:
		var block = BLOCK_SCENE.instantiate()
		block.block_freed.connect(check_empty_and_free)
		block.texture = PALLETE
		block.offset = Vector2(Globals.BLOCK_SIZE/2, Globals.BLOCK_SIZE/2)
		block.region_enabled = true
		block.region_rect = Rect2(COLORS[_shape_name] * Globals.BLOCK_SIZE, 0, Globals.BLOCK_SIZE, Globals.BLOCK_SIZE)
		block.position = (pos * Globals.BLOCK_SIZE)
		add_child(block)
		blocks.append(block)

func rotate_clockwise():
	if piece_name == "O":
		return
	for block in blocks:
		var new_position = Vector2(-block.position.y / Globals.BLOCK_SIZE, block.position.x / Globals.BLOCK_SIZE)
		block.position = new_position * Globals.BLOCK_SIZE

func rotate_counterclockwise():
	if piece_name == "O":
		return
	for block in blocks:
		var new_position = Vector2(block.position.y / Globals.BLOCK_SIZE, -block.position.x / Globals.BLOCK_SIZE)
		block.position = new_position * Globals.BLOCK_SIZE

func move_left():
	position.x -= Globals.BLOCK_SIZE
	#for block in blocks:
		#block.position.x -= Globals.BLOCK_SIZE


func move_right():
	position.y += Globals.BLOCK_SIZE
	#for block in blocks:
		#block.position.x += Globals.BLOCK_SIZE

func fall(delta: float):
	fall_timer += delta
	if fall_timer >= Globals.falling_speed:
		position.y += Globals.BLOCK_SIZE
		#for block in blocks:
			#block.position.y += Globals.BLOCK_SIZE
		fall_timer = 0.0

func check_empty_and_free():
	if get_child_count() == 0:
		queue_free()
