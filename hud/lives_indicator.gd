extends HFlowContainer
const HEART = preload("res://hud/heart.tscn")

func _update_hearts(lives: int) -> void:
    # TODO: Use more scalable approach
    var cnt = 0;
    for child in get_children():
        cnt += 1
    
    var didx = 0;
    while cnt > lives:
        get_child(didx).get_node("AnimationPlayer").play('break')
        cnt -= 1;
        didx += 1;
    
    for idx in lives - cnt:
        var heart = HEART.instantiate()
        add_child(heart)

func _init() -> void:
    Events.PLAYER_LIVES_UPDATED.connect(_update_hearts)
    
func _ready() -> void:
    _update_hearts(GameManager.player.lives)
    
        
