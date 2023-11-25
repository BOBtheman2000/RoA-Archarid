// attacked a web point

if instance_exists(tethered_player) {
    if hit_player_obj == tethered_player {
        queue_snap = true
    }

    var attack = enemy_hitboxID.attack

    if hit_player_obj.barney_archarid_yes && (attack == AT_DSTRONG || attack == AT_USTRONG || attack == AT_FSTRONG) {
        queue_snap = true
    }
} else {
    queue_snap = true
}