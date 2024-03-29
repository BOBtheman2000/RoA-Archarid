lifetime++

// we're fine with being stuck in a wall, just not spawning inside them
ignores_walls = true
disable_movement = true

var spritesheet_length = 4
var animation_time = 4
var animation_timer = get_gameplay_time()

if doing_hurt_animation {
    hurt_animation_timer++
    if hurt_animation_timer > hurt_animation_time {
        hurt_animation_timer = 0
        doing_hurt_animation = false
        real_sprite_index = doing_blink ? sprite_blink : sprite_idle
        real_image_index = 0
    } else {
        animation_timer = hurt_animation_timer
        animation_time = ceil(hurt_animation_time / 4)
        spritesheet_length = 4
    }
} else if doing_blink {
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
if instance_exists(tethered_player) && !override_all {

    array_push(tether_list, point_direction(x, y, tethered_player.x, tethered_player.y))

    // print(tension)

    with(tethered_player) {

        if (state == PS_DEAD || state == PS_RESPAWN) {
            other.queue_snap = true
            break
        }

        if free {
            other.tether_airtime++
            if other.tether_airtime > other.tether_airtime_max {
                set_state(PS_PRATFALL)
                other.queue_snap = true
                break
            }
        } else {
            other.tether_airtime = 0
        }

        var tether_max = other.tether_distance_max

        if barney_archarid_yes && (state == PS_ATTACK_AIR || state == PS_ATTACK_GROUND) && attack == AT_DSPECIAL {
            tether_max = other.tether_distance_max_archarid
        }

        if barney_archarid_yes && has_rune("E") {
            if other.lifetime % 60 == 0 {
                sound_play(asset_get("mfx_xp"), false, noone, 1, 2)
                outline_color[1] = 200
                init_shader()
                take_damage(player, -1, -1)
            }
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
            spawn_hit_fx(x, y, HFX_GEN_SWEET)
            break
        }
        
        if state == PS_HITSTUN {
            other.tether_airtime = 0
            if shield_pressed {
                // play the hurt animation when we tech the wall
                set_state(PS_WALL_TECH)
                other.doing_hurt_animation = true
                other.hurt_animation_timer = 0
                other.real_sprite_index = other.sprite_hurt
                other.real_image_index = 0
            }
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
            if barney_archarid_yes {
                other.prime_dspecial_cooldown = true
            }
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
    tether_airtime = 0
    if !queue_snap {
        prime_dspecial_cooldown = false
    }
}

var cone_last_angle_dist = 9999

for (i=0; i < array_length_1d(tethered_orbs); i++) {

    var tethered_orb = tethered_orbs[i].target

    if !instance_exists(tethered_orb) {
        otherCone = noone
        continue
    }

    // flo compat
    if array_length_1d(tethered_orbs) <= 1 {
        otherCone = tethered_orb
    } else {
        // "cones" now have to compete for flo's attention

        var closest_flo = player_id
        var closest_dist = 999999999
        with (oPlayer) {
            if url == "3048939652" {
                var dist = distance_to_object(other)
                if dist < closest_dist {
                    closest_flo = self
                    closest_dist = dist
                }
            }
        }

        var tether_dir = point_direction(x, y, tethered_orb.x, tethered_orb.y)
        var flo_dir = point_direction(x, y, closest_flo.x, closest_flo.y)

        var flo_angle = abs(tether_dir - flo_dir)
        if flo_angle < cone_last_angle_dist {
            cone_last_angle_dist = flo_angle
            otherCone = tethered_orb
        }
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
                if jump_pressed && (barney_archarid_airtime_jumps <= other.jump_count_max) {
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

                        // modifier that decreases jump height with each consecutive jump
                        // would've fixed this earlier if it wasn't delivered to me by the most fragile streamer imaginable LMAO
                        barney_archarid_airtime_jumps += 1
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
                continue
            }
            if !player_id.barney_archarid_yes {
                continue
            }
            if attack == AT_FSPECIAL && hbox_num == 1 {
                var proj_collision = collision_line(other.x, other.y, tethered_orb.x, tethered_orb.y, id, true, false)
                if proj_collision != noone {
                    var line_dir = point_direction(other.x, other.y, tethered_orb.x, tethered_orb.y)
                    var spread = 12
                    barney_archarid_orb_hit = true
                    barney_archarid_tether_top_x = lengthdir_x(-spread, line_dir)
                    barney_archarid_tether_top_y = lengthdir_y(-spread, line_dir)
                    barney_archarid_tether_bottom_x = lengthdir_x(spread, line_dir)
                    barney_archarid_tether_bottom_y = lengthdir_y(spread, line_dir)
                }
                continue
            }
            if attack != AT_NSPECIAL {
                continue
            }

            var proj_collision = collision_line(other.x, other.y, tethered_orb.x, tethered_orb.y, id, true, false)
            if proj_collision != noone {
                orb_data.jumping_player = id
                potential_direction = point_direction(0, 0, hsp, vsp) + 180
                hsp = 0
                vsp = 0
                orb_data.jumping_type = 'proj'
                sprite_index = player_id.nspecial_sprite
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
                var jump_mod = 1.0
                if orb_data.jumping_hitstun {
                    hitstun = hitstun_full
                } else {
                    // stall fix
                    if barney_archarid_airtime_jumps >= 3 {
                        // not a cheap calculation but we're doing this once a millenia
                        jump_mod = min(1.0, power(barney_archarid_airtime_jumps - 2, -other.jump_falloff_mod))
                    }
                }
                var phantom_interrupt = false
                if barney_archarid_yes && has_rune("J") {
                    if special_pressed {
                        phantom_interrupt = true
                        phantom_tether_interrupt = true
                        phantom_tethered = true
                        barney_archarid_tethered_to_orb = true
                        barney_archarid_current_orb = other
                    }
                }
                x = lerp(x, orb_data.jump_midpoint_x, 0.6)
                y = lerp(y, orb_data.jump_midpoint_y, 0.6)
                if orb_data.jumping_state_timer <= 0 || shield_pressed || phantom_interrupt {
                    orb_data.jumping_lockout = 10
                    orb_data.jumping_state_timer = 0

                    if shield_pressed || phantom_interrupt {
                        if orb_data.jumping_hitstun {
                            set_state(PS_PRATFALL)
                            other.queue_snap = true
                            tethered_orb.queue_snap = true

                            sound_play(asset_get("sfx_tech"), false, noone, 1, 1)
                            white_flash_timer = 20
                        } else {
                            set_state(PS_DOUBLE_JUMP)
                            clear_button_buffer(PC_SHIELD_PRESSED)
                        }
                        hsp = 0
                        vsp = 0
                    } else {
                        hsp = lengthdir_x(orb_data.jump_strength * jump_mod, orb_data.jumping_player_direction)
                        vsp = lengthdir_y(orb_data.jump_strength * jump_mod, orb_data.jumping_player_direction)
                    }

                    sound_stop(orb_data.jump_pull_sound)
                    sound_play(asset_get("sfx_leafy_hit1"), false, noone, 1, 1.4)
                    spawn_hit_fx(lerp(other.x, tethered_orb.x, 0.5), lerp(other.y, tethered_orb.y, 0.5), HFX_GEN_SWEET)
                }
            }
        
        }

        if orb_data.jumping_type == 'proj' {

            if !instance_exists(orb_data.jumping_player) {
                // projectile was destroyed somewhere, so we just give up on this one
                orb_data.jumping_lockout = 10
                orb_data.jumping_state_timer = 0
                sound_stop(orb_data.jump_pull_sound)

            } else {

                var influenced_direction = orb_data.jumping_player_direction
                var min_influence = 9999

                with (oPlayer) {
                    if id == orb_data.jumping_player.last_player_id {
                        continue
                    }
                    var jp = orb_data.jumping_player
                    var my_dir = point_direction(jp.x + jp.hsp, jp.y + jp.vsp + 16, x, y)
                    var angle_diff = angle_difference(orb_data.jumping_player_direction, my_dir)
                    if abs(angle_diff) < abs(min_influence) {
                        min_influence = angle_diff
                    }
                }

                if abs(min_influence) < 20 {
                    influenced_direction -= min_influence
                }

                with (orb_data.jumping_player) {
                    x = lerp(x, orb_data.jump_midpoint_x, 0.6)
                    y = lerp(y, orb_data.jump_midpoint_y, 0.6)
                    hitbox_timer = 0
                    if orb_data.jumping_state_timer <= 0 {
                        orb_data.jumping_lockout = 10
                        orb_data.jumping_state_timer = 0

                        sprite_index = player_id.nspecial_sprite_fast

                        hsp = lengthdir_x(player_id.nspecial_speed_fast, influenced_direction)
                        vsp = lengthdir_y(player_id.nspecial_speed_fast, influenced_direction)

                        spr_dir = sign(lengthdir_x(1, influenced_direction))

                        draw_xscale = spr_dir

                        kb_angle = influenced_direction
                        if spr_dir = -1 && influenced_direction > 90 {
                            kb_angle = kb_angle - 180
                        }

                        damage = player_id.nspecial_damage_fast
                        kb_value = player_id.nspecial_kb_fast
                        kb_scale = player_id.nspecial_kb_scaling_fast
                        hitpause = player_id.nspecial_hitpause_fast
                        hitpause_growth = player_id.nspecial_hitpause_scaling_fast
                        force_flinch = 0

                        proj_angle = influenced_direction
                        if spr_dir = -1 && influenced_direction > 90 {
                            proj_angle = proj_angle - 180
                        }

                        sound_stop(orb_data.jump_pull_sound)
                        sound_play(asset_get("sfx_leafy_hit1"), false, noone, 1, 1.4)
                        spawn_hit_fx(lerp(other.x, tethered_orb.x, 0.5), lerp(other.y, tethered_orb.y, 0.5), HFX_ORI_BASH_START)
                    }
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
        if prime_dspecial_cooldown && ("barney_archarid_yes" in tethered_player) {
            if tethered_player.barney_archarid_yes {
                tethered_player.move_cooldown[AT_DSPECIAL] = 2
            }
        }
    }
    for (i=0; i < array_length_1d(tethered_orbs); i++) {
        var orb_data = tethered_orbs[i]
        
        if "jump_pull_sound" in orb_data {
            sound_stop(orb_data.jump_pull_sound)
        }
        if "jumping_type" in orb_data {
            if orb_data.jumping_type == 'proj' && instance_exists(orb_data.jumping_player) {
                orb_data.jumping_player.destroyed_next = true
            }
        }
        var tethered_orb = tethered_orbs[i].target
        if instance_exists(tethered_orb) {
            tethered_orb.awaiting_snap = snap_delay_time
            tethered_orb.awaiting_snap_x = x
            tethered_orb.awaiting_snap_y = y
        }
    }
    spawn_hit_fx(x + draw_x, y + draw_y, death_vfx)

    if has_rune("B") {
        spawn_hit_fx(x + draw_x, y + draw_y, HFX_ELL_FSPEC_HIT)
        sound_play(asset_get("sfx_ell_strong_attack_explosion"), false, noone, 1, 1)
        create_hitbox(AT_DSPECIAL, 3, floor(x + draw_x), floor(y + draw_y))
    }

    instance_destroy()
}