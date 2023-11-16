// empty

if get_gameplay_time() % 4 == 0 {
    image_index++
}

var tether_max_x = x + tether_distance_max
var tether_min_x = x - tether_distance_max

var tether_max_y = y + tether_distance_max
var tether_min_y = y - tether_distance_max

with(tethered_player) {

    var tether_distance = point_distance(x, y, other.x, other.y)
    var tether_diff = tether_distance - other.tether_distance_max

    other.tension = max(0, tether_diff / other.tether_distance_snap)

    if tether_diff > 0 {
        if other.tension > 1 || abs(hsp) > other.tether_hsp_snap || abs(vsp) > other.tether_vsp_snap {
            other.queue_snap = true
            break
        }

        var tether_direction = point_distance(x, y, other.x, other.y)

        hsp = sign(other.x - x) * abs(lengthdir_x(tether_diff, tether_direction)) * other.tether_spring_mult_x
        if free {
            vsp = sign(other.y - y) * abs(lengthdir_y(tether_diff, tether_direction)) * other.tether_spring_mult_y
        }

        if state == PS_PRATFALL {

            state = PS_IDLE_AIR

        }

        if state == PS_HITSTUN {
            can_tech = true
        }

    }
    
    x = lerp(x, clamp(x, tether_min_x, tether_max_x), other.tether_clamp_strength)
    y = lerp(y, clamp(y, tether_min_y, tether_max_y), other.tether_clamp_strength)

}

if queue_snap {
    sound_play(snap_sound, false, false, 1, 2)
    if tether_type == 'player' {
        tethered_player.barney_archarid_tethered_to_orb = false
    }
    instance_destroy()
}