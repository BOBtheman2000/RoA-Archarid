if get_gameplay_time() % 4 == 0 {
    image_index++
}

print(tension)

// Player tethering behaviour
with(tethered_player) {

    // print("x: " + string(x) + " y: " + string(y) + " hsp: " + string(hsp) + " vsp: " + string(vsp))

    var tether_distance = point_distance(other.x, other.y, x, y)
    var tension = tether_distance - other.tether_distance_max

    if tension < 0 {
        tension = 0
        break
    }

    var damage = min(get_player_damage(player), other.tether_tension_snap_hitstun_damage_max - 1)

    // Formula for tension limiter based on damage falloff
    var tension_snap_hitstun_mod = (
        other.tether_tension_snap_hitstun + (
            other.tether_tension_snap_hitstun_thresh_modifier / (
                damage - other.tether_tension_snap_hitstun_damage_max
                )
            ) + other.tether_tension_snap_hitstun_thresh_modifier / other.tether_tension_snap_hitstun_damage_max
        )

    tension_snap_hitstun_mod = max(tension_snap_hitstun_mod, other.tether_tension_snap_hitstun_min)
    
    other.tension_thresh = tension / (state == PS_HITSTUN ? tension_snap_hitstun_mod : other.tether_tension_snap)

    print(other.tension_thresh)

    if other.tension_thresh > 1 {
        other.queue_snap = true
        break
    }
    
    if state == PS_HITSTUN && shield_pressed {
        set_state(PS_WALL_TECH)
    }

    var target_hsp = hsp * other.tether_looseness
    var target_vsp = vsp * other.tether_looseness

    var offset = point_distance(hsp, vsp, target_hsp, target_vsp)

    var target_x = x + target_hsp
    var target_y = y + target_vsp

    var bounce_direction = point_direction(target_x, target_y, other.x, other.y)

    // print("tho: " + string(target_hsp))
    // print("tvo: " + string(target_vsp))

    var bounce = (tension + offset) * other.tether_bounce_modifier

    // print("gh: " + string(lengthdir_x(bounce, bounce_direction)))
    // print("gv: " + string(lengthdir_y(bounce, bounce_direction)))

    target_hsp += lengthdir_x(bounce, bounce_direction)
    target_vsp += lengthdir_y(bounce, bounce_direction)

    // just in case this new vsp is bouncy, let's restore a jump
    if vsp > 0 && target_vsp < 0 {
        djumps = min(djumps, max_djumps - 1)
    }

    hsp = target_hsp
    vsp = target_vsp

    // print("bd: " + string(bounce_direction))
    // print("b: " + string(bounce))
    // print("th: " + string(target_hsp))
    // print("tv: " + string(target_vsp))
    // print("o: " + string(offset))
    // print("t: " + string(other.tension))

}

if queue_snap {
    sound_play(snap_sound, false, false, 1, 2)
    if tether_type == 'player' {
        tethered_player.barney_archarid_tethered_to_orb = false
    }
    instance_destroy()
}