lifetime++

var spritesheet_length = 4
var animation_time = 4
var animation_timer = get_gameplay_time()

if doing_blink {
    blink_timer++
    if blink_timer >= blink_animation_time {
        blink_timer = 60 + random_func(19, 240, true)
        doing_blink = false
        real_sprite_index = sprite_idle
        real_image_index = 0
    } else {
        animation_timer = blink_timer
        animation_time = ceil(blink_animation_time / 6)
        spritesheet_length = 6
    }
} else {
    blink_timer--
    if blink_timer <= 0 {
        doing_blink = true
        real_sprite_index = sprite_blink
        real_image_index = 0
    }
}

if animation_timer % animation_time == 0 {
    real_image_index = (real_image_index + 1) % spritesheet_length
}

tether_list = []

for (i=0; i < array_length_1d(tethered_orb_queue); i++) {
    var new_orb = tethered_orb_queue[i]
    array_push(tethered_orbs, {
        target: new_orb,
        parent: true,

        jumping_type: 'player',

        jumping_hitstun: false,

        jumping_lockout: 10,

        jumping_state_timer: 0,
        jumping_state_time_max: 0,

        jumping_player: noone,
        
        jumping_player_offset: 0,
        jumping_player_offset_max: 0,

        jumping_player_direction: 0,

        jump_strength: 0,

        jump_pull_sound: 0,

        jump_midpoint_x: 0,
        jump_midpoint_y: 0
    })
    with (new_orb) {
        array_push(tethered_orbs, {
            target:other,
            parent:false
        })
    }
}

tethered_orb_queue = []

// Player tethering behaviour
if instance_exists(tethered_player) {

    array_push(tether_list, point_direction(x, y, tethered_player.x, tethered_player.y))

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
            other.awaiting_snap = other.snap_delay_time
            other.awaiting_snap_x = x
            other.awaiting_snap_y = y
            other.tethered_player = noone
            barney_archarid_tethered_to_orb = false
            sound_play(other.snap_sound, false, noone, 1, 2)
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
}

for (i=0; i < array_length_1d(tethered_orbs); i++) {

    var tethered_orb = tethered_orbs[i].target

    if !instance_exists(tethered_orb) {
        continue
    }

    array_push(tether_list, point_direction(x, y, tethered_orb.x, tethered_orb.y))

    if !tethered_orbs[i].parent {
        continue
    }

    var orb_data = tethered_orbs[i]

    if orb_data.jumping_state_timer <= 0 {
        orb_data.jumping_player = noone

        if orb_data.jumping_lockout > 0 {
            orb_data.jumping_lockout--
            continue
        }

        var potential_direction = 0

        with (oPlayer) {

            if "barney_archarid_tethered_to_orb" in self {
                if barney_archarid_tethered_to_orb {
                    continue
                }
            }

            var player_collision = collision_line(other.x, other.y, tethered_orb.x, tethered_orb.y, id, true, false)
            if player_collision != noone {
                if jump_pressed {
                    if (state == PS_JUMPSQUAT || state == PS_FIRST_JUMP || state == PS_DOUBLE_JUMP || state == PS_WALL_JUMP || state == PS_IDLE_AIR) {
                        hsp = 0
                        vsp = 0
                        set_state(PS_IDLE_AIR)
                        clear_button_buffer(PC_JUMP_PRESSED)
                        orb_data.jumping_player = id
                        orb_data.jumping_hitstun = false
                        orb_data.jumping_type = 'player'

                        // bias towards up, unless we really wanna go downward
                        potential_direction = 90
                        if down_down {
                            potential_direction = joy_dir
                        }

                        // you look sad. have your double jump back :)
                        djumps = min(djumps, max_djumps - 1)
                    }
                }
                if state == PS_HITSTUN {
                    orb_data.jumping_player = id
                    orb_data.jumping_type = 'player'
                    potential_direction = point_direction(0, 0, hsp, vsp) + 180
                    hsp = 0
                    vsp = 0
                    orb_data.jumping_hitstun = true
                }
            }
        }

        with (pHitBox) {
            if "barney_archarid_yes" not in player_id {
                break
            }
            if !player_id.barney_archarid_yes {
                break
            }
            if attack != AT_NSPECIAL {
                break
            }

            var proj_collision = collision_line(other.x, other.y, tethered_orb.x, tethered_orb.y, id, true, false)
            if proj_collision != noone {
                orb_data.jumping_player = id
                potential_direction = point_direction(0, 0, hsp, vsp) + 180
                hsp = 0
                vsp = 0
                orb_data.jumping_type = 'proj'
            }
        }


        if instance_exists(orb_data.jumping_player) {
            var jumping_player = orb_data.jumping_player
            orb_data.jumping_player_offset = 0
            orb_data.jump_midpoint_x = lerp(x, tethered_orb.x, 0.5)
            orb_data.jump_midpoint_y = lerp(y, tethered_orb.y, 0.5)

            // calculate jump direction
            var tether_direction = point_direction(x, y, tethered_orb.x, tethered_orb.y)
            orb_data.jumping_player_direction = tether_direction - 90
            if abs(angle_difference(
                potential_direction, tether_direction + 90
                )) < abs(angle_difference(
                potential_direction, tether_direction - 90
                )) {
                // we don't actually know if this is up or down, this just favours whichever half your stick direction ends up in
                orb_data.jumping_player_direction = tether_direction + 90
            }

            // modify jump start time & jump strength based on tether length
            var tether_length = point_distance(x, y, tethered_orb.x, tethered_orb.y)
            orb_data.jumping_state_time_max = ceil(tether_length / jumping_state_time_max_mod)
            orb_data.jump_strength = ceil(tether_length / jump_strength_mod) + jump_strength_base
            orb_data.jumping_player_offset_max = orb_data.jumping_state_time_max
            orb_data.jumping_state_timer = orb_data.jumping_state_time_max
        }
    } else {
        sound_stop(orb_data.jump_pull_sound)
        orb_data.jump_pull_sound = sound_play(asset_get("sfx_may_wrap1"), false, noone, 1, 1.6 - (orb_data.jumping_state_timer / 10))
        orb_data.jumping_state_timer = max(orb_data.jumping_state_timer - 1, 0)
        orb_data.jumping_player_offset = lerp(orb_data.jumping_player_offset, orb_data.jumping_player_offset_max, 0.5)

        var pull_direction = orb_data.jumping_player_direction - 180

        orb_data.jump_midpoint_x = lerp(x, tethered_orb.x, 0.5) + lengthdir_x(orb_data.jumping_player_offset, pull_direction)
        orb_data.jump_midpoint_y = lerp(y, tethered_orb.y, 0.5) + lengthdir_y(orb_data.jumping_player_offset, pull_direction)

        if orb_data.jumping_type == 'player' {

            with (orb_data.jumping_player) {
                if orb_data.jumping_hitstun {
                    hitstun = hitstun_full
                }
                x = lerp(x, orb_data.jump_midpoint_x, 0.6)
                y = lerp(y, orb_data.jump_midpoint_y, 0.6)
                if orb_data.jumping_state_timer <= 0 || shield_pressed {
                    orb_data.jumping_lockout = 10
                    orb_data.jumping_state_timer = 0

                    if shield_pressed {
                        if orb_data.jumping_hitstun {
                            set_state(PS_PRATFALL)
                            other.queue_snap = true
                            tethered_orb.queue_snap = true
                        } else {
                            set_state(PS_DOUBLE_JUMP)
                            clear_button_buffer(PC_SHIELD_PRESSED)
                        }
                        hsp = 0
                        vsp = 0
                    } else {
                        hsp = lengthdir_x(orb_data.jump_strength, orb_data.jumping_player_direction)
                        vsp = lengthdir_y(orb_data.jump_strength, orb_data.jumping_player_direction)
                    }

                    sound_stop(orb_data.jump_pull_sound)
                    sound_play(asset_get("sfx_leafy_hit1"), false, noone, 1, 1.4)
                }
            }
        
        }

        if orb_data.jumping_type == 'proj' {

            with (orb_data.jumping_player) {
                x = lerp(x, orb_data.jump_midpoint_x, 0.6)
                y = lerp(y, orb_data.jump_midpoint_y, 0.6)
                hitbox_timer = 0
                if orb_data.jumping_state_timer <= 0 {
                    orb_data.jumping_lockout = 10
                    orb_data.jumping_state_timer = 0

                    sprite_index = player_id.nspecial_sprite_fast

                    hsp = lengthdir_x(player_id.nspecial_speed_fast, orb_data.jumping_player_direction)
                    vsp = lengthdir_y(player_id.nspecial_speed_fast, orb_data.jumping_player_direction)

                    spr_dir = sign(lengthdir_x(1, orb_data.jumping_player_direction))

                    print(lengthdir_x(1, orb_data.jumping_player_direction))
                    print(orb_data.jumping_player_direction)
                    print(spr_dir)

                    draw_xscale = spr_dir

                    kb_angle = orb_data.jumping_player_direction

                    damage = player_id.nspecial_damage_fast
                    kb_value = player_id.nspecial_kb_fast
                    kb_scale = player_id.nspecial_kb_scaling_fast
                    hitpause = player_id.nspecial_hitpause_fast
                    hitpause_growth = player_id.nspecial_hitpause_scaling_fast

                    proj_angle = orb_data.jumping_player_direction
                    if spr_dir = -1 && orb_data.jumping_player_direction > 90 {
                        proj_angle = proj_angle - 180
                    }

                    sound_stop(orb_data.jump_pull_sound)
                    sound_play(asset_get("sfx_leafy_hit1"), false, noone, 1, 1.4)
                }
            }

        }
    }
}

if array_length_1d(tethered_orbs) > 2 {
    queue_snap = true
}

if awaiting_snap > 0 {
    awaiting_snap--
    if awaiting_snap <= 0 {
        queue_snap = true
    }
}

if queue_snap {
    sound_play(snap_sound, false, noone, 1, 2)
    if instance_exists(tethered_player) {
        tethered_player.barney_archarid_tethered_to_orb = false
    }
    for (i=0; i < array_length_1d(tethered_orbs); i++) {
        var tethered_orb = tethered_orbs[i].target
        if instance_exists(tethered_orb) {
            tethered_orb.awaiting_snap = snap_delay_time
            tethered_orb.awaiting_snap_x = x
            tethered_orb.awaiting_snap_y = y
        }
    }
    spawn_hit_fx(x + draw_x, y + draw_y, death_vfx)
    instance_destroy()
}