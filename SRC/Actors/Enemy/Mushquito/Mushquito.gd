extends Node2D

const IDLE_DURATION = 1.0

export var move_direction = Vector2.UP * 192
export var speed = 3.0

var follow = Vector2.ZERO

onready var platform = $Platform
onready var tween = $Platform/Tween

func _ready():
	_init_tween()
	
func _init_tween():
	var duration = move_direction.length() / float(speed * 16)
	tween.interpolate_property(self, "follow",Vector2.ZERO,move_direction, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,IDLE_DURATION)
	tween.interpolate_property(self, "follow",move_direction, Vector2.ZERO, duration,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT,duration + IDLE_DURATION * 2)
	tween.start()

func _physics_process(delta):
	platform.position = platform.position.linear_interpolate(follow,0.075)