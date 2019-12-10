class_name Particle extends KinematicBody2D

var trans
var velocity
const GRAVITY = Vector2(0, 2)
var rot = [-0.7, 0.7]
var speed = [200, 400]
var life_time = [200, 400]

var life = 2


func _ready():
	rot = rand_range(rot[0], rot[1])
	rotate(rand_range(-1, 1))
	speed = Vector2(rand_range(speed[0], speed[1]),rand_range(speed[0], speed[1]))
	life_time = rand_range(life_time[0], life_time[1])
	position += Vector2(rand_range(0,10)-5,rand_range(0,10)-5)
	trans += Vector2(rand_range(0,0.6)-.3,rand_range(0,0.6)-.3)
	velocity = speed * trans


func _physics_process(_delta):
	life_time -= 1
	if life_time < 0:
		self.queue_free()
	velocity = move_and_slide(velocity + GRAVITY)
	rotate(rot)



func _on_Area2D_body_entered(body):
	if life > 0:
		if body is TileMap:
			pass
		else:
			body.deactivate()
		life -= 1
		if life <= 0:
			self.queue_free()
			
