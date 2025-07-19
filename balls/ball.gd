extends CharacterBody2D
class_name Ball


signal hitted_damageable(collision_info: KinematicCollision2D)

@export var weight: int = 10
@export var _health: Health
@export var bounce_type: BOUNCE_TYPE
@export var bounce_audio_player: OneShotAudioPlayer

var triggers: Array[Trigger]

@onready var _visible_on_screen_notifier_2D: VisibleOnScreenNotifier2D = NodeUtils.get_child_by_class(self, VisibleOnScreenNotifier2D)

enum BOUNCE_TYPE {NORMAL, REVERSE, SNIPER, CANNON}


func _ready() -> void:
	reset_physics_interpolation()
	
	_visible_on_screen_notifier_2D.screen_exited.connect(_on_death)
	_health.died.connect(queue_free)

	triggers.append(TriggerDamageable.new())
	hitted_damageable.connect(triggers[0].trigger)
	

func _physics_process(delta) -> void:
	velocity += get_gravity()
	
	var collision_info: KinematicCollision2D = move_and_collide(velocity * delta)
	if collision_info:
		var _collider: Object = collision_info.get_collider()
		var hitted_enemy := false
		
		if _collider is Paddle:
			_collider.ball_hit(self)
			return
		elif _collider.has_method("take_damage"):
			hitted_damageable.emit(collision_info)
			hitted_enemy = true

		bounce_audio_player.one_shot_play(Level.instance)
		velocity = calculate_baunce(bounce_type, collision_info, hitted_enemy)

		_health.take_damage(1)
		move_and_collide(velocity * delta)


func calculate_baunce(bounce_type: BOUNCE_TYPE, collision_info: KinematicCollision2D, hitted_enemy: bool) -> Vector2:
	var normal: Vector2 = collision_info.get_normal()
	var bounce: Vector2 = velocity.bounce(normal)

	match bounce_type:
		BOUNCE_TYPE.NORMAL:
			bounce = velocity.bounce(normal)
		BOUNCE_TYPE.REVERSE:
			bounce = velocity.rotated(PI)
		BOUNCE_TYPE.SNIPER:
			if not hitted_enemy:
				var enemies := get_tree().get_nodes_in_group("enemies")
				
				if enemies:
					var nearest_node: Node2D = null
					var nearest_distance: float = INF

					for node in enemies:
						var dist = global_position.distance_to(node.global_position)
						if dist < nearest_distance:
							nearest_distance = dist
							nearest_node = node

					bounce = (nearest_node.global_position - global_position).normalized() * velocity.length()
		BOUNCE_TYPE.CANNON:
			if collision_info.get_collider().is_queued_for_deletion():
				bounce = velocity

	return bounce + collision_info.get_collider_velocity() * 0.5


func _on_death() -> void:
	queue_free()


func take_damage(amount: int) -> void:
	_health.take_damage(amount)


func heal(amount: int) -> void:
	_health.heal(amount)
