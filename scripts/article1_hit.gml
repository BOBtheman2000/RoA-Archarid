// attacked a web point

hit_player_obj.has_hit = true

var attack = enemy_hitboxID.attack

var been_hit = false

if instance_exists(tethered_player) {
    if hit_player_obj == tethered_player {
        if !(hit_player_obj.barney_archarid_yes && attack == AT_FSPECIAL) { // archarid fspecial should go through web points
            been_hit = true
        }
    } else {
        if hit_player_obj.barney_archarid_yes {
            if (attack == AT_DSTRONG || attack == AT_USTRONG || attack == AT_FSTRONG) {
                been_hit = true
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
                    been_hit = true
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
        } else if attack == AT_FSPECIAL {
            with (enemy_hitboxID) {
                barney_archarid_orb_hit = true
                barney_archarid_tether_top_x = 0
                barney_archarid_tether_top_y = -6
                barney_archarid_tether_bottom_x = 0
                barney_archarid_tether_bottom_y = 6
            }
        } else {
            been_hit = true
        }
    } else {
        been_hit = true
    }
}

if been_hit {
    enemy_hitboxID.has_hit = true
    queue_snap = true
    spawn_hit_fx(x + enemy_hitboxID.hit_effect_x, y + enemy_hitboxID.hit_effect_y, enemy_hitboxID.hit_effect)
    sound_play(enemy_hitboxID.sound_effect)
}

// setup like this in case something else was also hit this frame
// doesn't properly account for everything but should suffice for making things not look weird
if !enemy_hitboxID.has_hit && !been_hit {
    hitstop = 0
    hit_player_obj.hitstop = 0
}