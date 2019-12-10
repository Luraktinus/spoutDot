class_name Player extends KinematicBody2D

onready var particle = preload('res://Particle.tscn')
onready var particle2 = preload("res://Testing/Particle_Rigid.tscn")

const SPEED = 4
const FRICTION = 0.99
const FRICTION_ROTATION = 0.9
const GRAVITY = Vector2(0,1)

var velocity = Vector2()
var rotate_left
var rotate_right
var rotation_vel = 0
var thrust
var movement_acceleration


func _ready():
	add_to_group('Players')


func _physics_process(_delta):
	rotate_left = Input.is_action_pressed("ui_left")
	rotate_right = Input.is_action_pressed("ui_right")
	thrust = Input.is_action_pressed("ui_up")
	rota()
	
	if thrust:
		create_particles(2)
		velocity += transform.y *- SPEED
	velocity += GRAVITY
	velocity *= FRICTION
	velocity = move_and_slide(velocity, Vector2(0, -1))


func rota():
	if rotate_left:
		rotation_vel -= 0.05
	if rotate_right:
		rotation_vel += 0.05
	rotation_vel *= max(0.8, min(0.99, rotation_vel*2))
	rotation += rotation_vel


func create_particles(n):
	for _i in range(n):
		var new_particle = particle2.instance()
		new_particle.position = $'ParticleCreator'.global_position
		new_particle.trans = transform.y
		$"..".add_child(new_particle)



