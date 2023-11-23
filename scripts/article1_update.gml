if get_gameplay_time() % 4 == 0 {
    image_index++
}

// Player tethering behaviour
if tether_type == 'player' {

    if instance_exists(tethered_player) {

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
                if state == PS_PRATFALL {
                    set_state(PS_IDLE_AIR)
                }
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
    } else {
        queue_snap = true
    }
}

if tether_type == 'orb' {
    if jumping_state_timer <= 0 {
        jumping_player = noone
        with (oPlayer) {
            var player_collision = collision_line(other.x, other.y, other.tethered_orb.x, other.tethered_orb.y, id, true, false)
            if player_collision != noone && jump_pressed {
                if (state == PS_JUMPSQUAT || state == PS_FIRST_JUMP || state == PS_DOUBLE_JUMP || state == PS_WALL_JUMP || state == PS_IDLE_AIR) {
                    hsp = 0
                    vsp = 0
                    set_state(PS_IDLE_AIR)
                    clear_button_buffer(PC_JUMP_PRESSED)
                    other.jumping_player = self

                    // you look sad. have your double jump back :)
                    djumps = min(djumps, max_djumps - 1)
                }
            }
        }
        if jumping_player != noone {
            jumping_state_timer = jumping_state_time_max
            jumping_player_offset = 0
            jump_midpoint_x = lerp(x, tethered_orb.x, 0.5)
            jump_midpoint_y = lerp(y, tethered_orb.y, 0.5)

            // calculate jump direction
            var potential_direction = jumping_player.joy_dir
            var tether_direction = point_direction(x, y, tethered_orb.x, tethered_orb.y)
            if jumping_player.joy_pad_idle {
                // bias towards up
                potential_direction = 90
            }
            jumping_player_direction = tether_direction - 90
            if abs(angle_difference(
                potential_direction, tether_direction + 90
                )) < abs(angle_difference(
                potential_direction, tether_direction - 90
                )) {
                // we don't actually know if this is up or down, this just favours whichever half your stick direction ends up in
                jumping_player_direction = tether_direction + 90
            }

            // modify jump start time & jump strength based on tether length
            var tether_length = point_distance(x, y, tethered_orb.x, tethered_orb.y)
            jumping_state_time_max = ceil(tether_length / jumping_state_time_max_mod)
            jump_strength = ceil(tether_length / jump_strength_mod) + jump_strength_base
            jumping_player_offset_max = jumping_state_time_max
        }
    } else {
        sound_stop(jump_pull_sound)
        jump_pull_sound = sound_play(asset_get("sfx_may_wrap1"), false, noone, 1, 1.6 - (jumping_state_timer / 10))
        jumping_state_timer = max(jumping_state_timer - 1, 0)
        jumping_player_offset = lerp(jumping_player_offset, jumping_player_offset_max, 0.5)
        jump_midpoint_x = lerp(x, tethered_orb.x, 0.5) + lengthdir_x(jumping_player_offset, -jumping_player_direction)
        jump_midpoint_y = lerp(y, tethered_orb.y, 0.5) + lengthdir_y(jumping_player_offset, -jumping_player_direction)
        with (jumping_player) {
            x = lerp(x, other.jump_midpoint_x, 0.6)
            y = lerp(y, other.jump_midpoint_y, 0.6)
            if other.jumping_state_timer <= 0 || shield_pressed {
                other.jumping_state_timer = 0
                hsp = lengthdir_x(other.jump_strength, other.jumping_player_direction)
                vsp = lengthdir_y(other.jump_strength, other.jumping_player_direction)
                sound_stop(other.jump_pull_sound)
                sound_play(asset_get("sfx_leafy_hit1"), false, noone, 1, 1.4)
            }
        }
    }
}

if queue_snap {
    sound_play(snap_sound, false, false, 1, 2)
    if tether_type == 'player' && instance_exists(tethered_player) {
        tethered_player.barney_archarid_tethered_to_orb = false
    }
    if instance_exists(tethered_orb) {
        tethered_orb.tether_type = 'none'
        tethered_orb.queue_snap = true
    }
    instance_destroy()
}