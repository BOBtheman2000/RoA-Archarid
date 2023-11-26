// attacked a web point

hit_player_obj.has_hit = true

var attack = enemy_hitboxID.attack

if instance_exists(tethered_player) {
    if hit_player_obj == tethered_player {
        queue_snap = true
    } else {
        if hit_player_obj.barney_archarid_yes {
            if (attack == AT_DSTRONG || attack == AT_USTRONG || attack == AT_FSTRONG) {
                queue_snap = true
            }
            if (attack == AT_DSPECIAL) {
                if hit_player_obj.barney_archarid_tethered_to_orb {
                    // free JUST hit_player_obj, tether these 2 orbs together, don't bother with THIS orb's tethered player
                    hit_player_obj.barney_archarid_tethered_to_orb = false
                    var my_orb = tethered_player.barney_archarid_current_orb
                    var archarid_orb = hit_player_obj.barney_archarid_current_orb

                    archarid_orb.tethered_player = noone
                    array_push(my_orb.tethered_orb_queue, archarid_orb)
                    sound_play(snap_sound, false, noone, 1, 2)

                } else {
                    queue_snap = true
                }
            }
        }
    }
} else {
    if hit_player_obj.barney_archarid_yes {
        if attack == AT_DSPECIAL {
            if hit_player_obj.barney_archarid_tethered_to_orb {
                tethered_player = noone
                hit_player_obj.barney_archarid_current_orb.tethered_player = noone
                hit_player_obj.barney_archarid_tethered_to_orb = false
                array_push(hit_player_obj.barney_archarid_current_orb.tethered_orb_queue, id)
            } else {
                tethered_player = hit_player_obj
                hit_player_obj.barney_archarid_tethered_to_orb = true
                hit_player_obj.barney_archarid_current_orb = id
            }
            sound_play(snap_sound, false, noone, 1, 2)
        } else if attack == AT_NSPECIAL {
            // do nothing
        } else {
            queue_snap = true
        }
    } else {
        queue_snap = true
    }
}