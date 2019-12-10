extends RigidBody2D


signal collided

var trans
var velocity
const GRAVITY = Vector2(0, 2)
var rot = [-0.7, 0.7]
var speed = [300, 500]
var life_time = [200, 300]
var mod = Vector2(0, 20) / 255
var life = 2


func _ready():
	self.connect('collided', get_parent().get_node('TileMap'), '_on_particle_collided')
	speed = Vector2(rand_range(speed[0], speed[1]),rand_range(speed[0], speed[1]))
	life_time = int(rand_range(life_time[0], life_time[1]))
	position += Vector2(rand_range(0,10)-5,rand_range(0,10)-5)
	trans += Vector2(rand_range(0,0.6)-.3,rand_range(0,0.6)-.3)
	rotate(rand_range(-1, 1))
	angular_velocity = rand_range(rot[0], rot[1])
	linear_velocity = speed * trans
	mod = rand_range(mod[0],mod[1])
	$Polygon2D.modulate = Color(mod,mod,mod)


func _physics_process(_delta):
	life_time -= 1
	if life_time < 0:
		self.queue_free()


func _integrate_forces(state):
	for i in state.get_contact_count():
		life -= 1
		if life == 0:
			self.queue_free()
		if state.get_contact_collider_object(i) is TileMap:
			var cpos = state.get_contact_collider_position(i)
			var n = state.get_contact_local_normal(i)
			emit_signal('collided', cpos, n)




