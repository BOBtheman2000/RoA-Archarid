if get_gameplay_time() % 4 == 0 {
    image_index++
}

// Player tethering behaviour
if tether_type == 'player' {

    // print(tension)

    with(tethered_player) {

        var tether_max = other.tether_distance_max

        if barney_archarid_yes && (state == PS_ATTACK_AIR || state == PS_ATTACK_GROUND) && attack == AT_DSPECIAL {
            tether_max = other.tether_distance_max_archarid
        }

        // print("x: " + string(x) + " y: " + string(y) + " hsp: " + string(hsp) + " vsp: " + string(vsp))

        var tether_distance = point_distance(other.x, other.y, x, y)
        var tension = tether_distance - tether_max

        if tension < 0 {
            tension = 0
            other.tether_snap_lockout = false
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

        // print(other.tension_thresh)

        if other.tension_thresh > 1 && !other.tether_snap_lockout {
            other.queue_snap = true
            break
        }
        
        if state == PS_HITSTUN && shield_pressed {
            set_state(PS_WALL_TECH)
        }

        var looseness = other.tether_looseness

        var target_hsp = hsp * looseness
        var target_vsp = vsp * looseness

        var offset = point_distance(hsp, vsp, target_hsp, target_vsp)

        var target_x = x + target_hsp
        var target_y = y + target_vsp

        var bounce_direction = point_direction(target_x, target_y, other.x, other.y)

        // print("tho: " + string(target_hsp))
        // print("tvo: " + string(target_vsp))

        // if we're in snap lockout, the bounce should be a LOT weaker
        // but this should scale with damage so we can still fling people around
        var tension_mod = other.tether_snap_lockout ? other.tether_bounce_modifier * damage / 1000 : other.tether_bounce_modifier

        var bounce = (tension + offset) * tension_mod

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
}

if queue_snap {
    sound_play(snap_sound, false, false, 1, 2)
    if tether_type == 'player' {
        tethered_player.barney_archarid_tethered_to_orb = false
    }
    if instance_exists(tethered_orb) {
        tethered_orb.tether_type = 'none'
        tethered_orb.queue_snap = true
    }
    instance_destroy()
}