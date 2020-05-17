extends KinematicBody2D

export var type = "enemy2"
export var MAX_SPEED = 50
export var ACCELERATION = 300
export var FRICTION = 200

const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

enum BatStates{
	IDLE, WANDER, CHASE
}

var batState = BatStates.CHASE

var velocity = Vector2.ZERO
var knockback = Vector2.ZERO

onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var animatedSprite = $AnimatedSprite
onready var hurtbox = $Hurtbox
onready var softCollisionComponent = $SoftCollisionComponent
onready var wanderController = $WanderController
onready var animationPlayer = $AnimationPlayer

func _ready():
	batState = pick_random_state([BatStates.IDLE, BatStates.WANDER])

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match batState:
		BatStates.IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			
			if wanderController.get_time_left() == 0:
				update_wander()
		
		BatStates.WANDER:
			seek_player()
			
			if wanderController.get_time_left() == 0:
				update_wander()
			
			accelerate_towards_position(wanderController.target_position, delta)
			
			if global_position.distance_to(wanderController.target_position) <= 10:
				update_wander()
		
		BatStates.CHASE:
			var player = playerDetectionZone.player
			if player != null:
				accelerate_towards_position(player.global_position, delta)
			else:
				batState = BatStates.IDLE
	
	if softCollisionComponent.is_colliding():
		velocity += softCollisionComponent.get_push_vector() * delta * ACCELERATION
	
	velocity = move_and_slide(velocity)

func accelerate_towards_position(position, delta):
	var direction = global_position.direction_to(position)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	if type == "Bat":
		animatedSprite.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2.flip_h = velocity.x < 0

func seek_player():
	if playerDetectionZone.can_see_player():
		batState = BatStates.CHASE

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func update_wander():
	batState = pick_random_state([BatStates.IDLE, BatStates.WANDER])
	wanderController.start_wander_timer(rand_range(1, 3))

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 150
	hurtbox.create_hit_effect()
	hurtbox.start_invincibility(0.4)

func _on_Stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position

func _on_Hurtbox_invincibility_started():
	if type == "Bat":
		animationPlayer.play("Start")
	else:
		$AnimationPlayer2.play("Start")

func _on_Hurtbox_invincibility_ended():
	if type == "Bat":
		animationPlayer.play("Stop")
	else:
		$AnimationPlayer2.play("Stop")
