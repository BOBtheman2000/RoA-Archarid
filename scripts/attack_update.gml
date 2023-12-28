// B - Reversals
if (attack == AT_NSPECIAL || attack == AT_FSPECIAL || attack == AT_DSPECIAL || attack == AT_USPECIAL){
    trigger_b_reverse();
}

if (attack == AT_JAB) {
    if (window <= 1 and window_timer <= 1) {
        // Prevents jab from instantly swoocing to the next hit
        clear_button_buffer(PC_ATTACK_PRESSED)
    }
    if (window == 8 and window_timer >= 4) {
        if (!attack_down && rapid_jab_timer <= 0) {
            window++;
        }
    }
}

if (attack == AT_DATTACK) {
    if window == 3 && window_timer == 1 {
        var dust = spawn_dust_fx(round(x + 20 * spr_dir), round(y), asset_get("empty_sprite"), 24)
        dust.dust_fx = 0
        dust.fg_sprite = 2620
        dust.dust_color = 0
    }
}

// neutral special
if (attack == AT_NSPECIAL) {
    can_fast_fall = true
    move_cooldown[AT_NSPECIAL] = 40
}

// up special
if (attack == AT_USPECIAL){
    if window == 1 {
        if barney_archarid_tethered_to_orb {
            uspecial_do_pratfall = false
            window = 4
            window_timer = 0
            move_cooldown[AT_DSPECIAL] = 2
        } else {
            uspecial_do_pratfall = true
            uspecial_orb_target_x = x + (uspecial_orb_x * spr_dir)
            uspecial_orb_target_y = y + uspecial_orb_y
        }
    }
    if window == 2 {
        if window_timer == get_window_value(AT_USPECIAL, 2, AG_WINDOW_LENGTH) {
            // create a new orb
            barney_archarid_tethered_to_orb = true
            barney_archarid_current_orb = instance_create(uspecial_orb_target_x, uspecial_orb_target_y, "obj_article1")
            barney_archarid_current_orb.tethered_player = id
            barney_archarid_current_orb.tension_snap_lockout = true
            barney_archarid_current_orb.override_all = true
            sound_play(web_point_spawn_sound, false, false, 1, 2)
        }
    }
    if (window == 3 || window == 4) && !barney_archarid_tethered_to_orb {
        // accounts for orb being broken early
        destroy_hitboxes()
        attack_end()
        set_state(PS_PRATFALL)
    }
    if window == 5 && window_timer == 1 {
        if instance_exists (barney_archarid_current_orb) {
            var orb_dir = point_direction(x, y, barney_archarid_current_orb.x, barney_archarid_current_orb.y)
            hsp = lengthdir_x(uspecial_boost_speed_x, orb_dir)
            vsp = lengthdir_y(uspecial_boost_speed_y, orb_dir)
        } else {
            destroy_hitboxes()
            attack_end()
            set_state(PS_PRATFALL)
        }
    }
    if window == 6 {
        if window_timer == get_window_value(AT_USPECIAL, 6, AG_WINDOW_LENGTH) && uspecial_do_pratfall {
            destroy_hitboxes()
            attack_end()
            set_state(PS_PRATFALL)
        }
    }
}

// Side special
if (attack == AT_FSPECIAL) {
    if window == 1 {
        fspecial_found_target = false
        fspecial_target_player = noone
        fspecial_draw_angle_override = false
    }
    if window == 2 {
        move_cooldown[AT_FSPECIAL] = 30

        var fspec_hitbox = noone
        with (pHitBox) {
            if player_id == other && attack == AT_FSPECIAL {
                fspec_hitbox = id
            }
        }
        if !instance_exists(fspec_hitbox) {
            if fspecial_found_target {
                window = 4
            } else {
                window++
            }
            window_timer = 0
        }
    }
    if window == 3 && window_timer == get_window_value(AT_FSPECIAL, 3, AG_WINDOW_LENGTH) {
        if free { 
            attack_end()
            set_state(PS_PRATFALL)
        }
    }
    if window == 4 {
        if instance_exists(fspecial_target_player) {
            if !fspecial_target_player.barney_archarid_tethered_to_orb {
                if window_timer == get_window_value(AT_FSPECIAL, 4, AG_WINDOW_LENGTH) - 1 {
                    create_hitbox(AT_FSPECIAL, 2, floor(fspecial_target_player.x), floor(fspecial_target_player.y))
                    window++
                    window_timer = 0
                }
            } else {
                with (fspecial_target_player) {
                    hsp = 0
                    vsp = 0
                    x = lerp(x, lerp(other.fspecial_target_x, other.x, 0.5), 0.6)
                    y = lerp(y, lerp(other.fspecial_target_y, other.y, 0.5), 0.6)
                    barney_archarid_current_orb.tether_snap_lockout = true
                }
            }
        } else {
            if window_timer == get_window_value(AT_FSPECIAL, 4, AG_WINDOW_LENGTH) - 1 {
                hsp = sign(fspecial_target_x - x) * 12
                vsp = -6
                sound_play(web_line_snap_sound, false, noone, 1, 1.6)
                attack_end()
                set_state(PS_IDLE_AIR)
            }
        }
    }
}

// Down special
if (attack == AT_DSPECIAL) {
    if window == 2 {
        if window_timer == get_window_value(AT_DSPECIAL, 3, AG_WINDOW_LENGTH) && (special_down && free) {
            window_timer--
        }
    }
    if window == 3 {
        if window_timer == 0 && !free {
            // these need to be mocked because of window 8 behavior
            hsp = get_window_value(AT_DSPECIAL, 3, AG_WINDOW_HSPEED) * spr_dir
            vsp = get_window_value(AT_DSPECIAL, 3, AG_WINDOW_VSPEED)
        }
    }
    if window == 4 {
        if window_timer == 1 && !hitstop && has_hit == false {
            if !barney_archarid_tethered_to_orb {
                // spawn new orb, i'm now attached
                barney_archarid_tethered_to_orb = true
                barney_archarid_current_orb = instance_create(x, y, "obj_article1")
                barney_archarid_current_orb.tethered_player = id
                sound_play(web_point_spawn_sound, false, false, 1, 2)
            } else {
                // reattach existing orb to new one
                barney_archarid_tethered_to_orb = false
                var new_orb = instance_create(x, y, "obj_article1")
                barney_archarid_current_orb.tethered_player = noone

                // cooldown ONLY happens if we leave dspecial untethered
                move_cooldown[AT_DSPECIAL] = 2

                // we should always be assigning the parent role to the newest orb so draw order doesn't get muddled
                array_push(new_orb.tethered_orb_queue, barney_archarid_current_orb)
                sound_play(web_point_spawn_sound, false, noone, 1, 2)
            }
        }
    }
    can_fast_fall = false;
    can_move = false
}

// wspecial
if (attack == AT_EXTRA_1) && window == 2 {
    var check_wall_x = x + (-40 * spr_dir)
    var check_wall_y_up = y - 30

    var available_up = collision_point(check_wall_x, check_wall_y_up, asset_get("par_block"), false, true) != noone

    if !available_up || jump_pressed {
        clear_button_buffer(PC_JUMP_PRESSED)
        set_state(PS_FIRST_JUMP)
        spr_dir = -spr_dir
        if jump_pressed {
            hsp = -walljump_hsp * spr_dir
            vsp = -walljump_vsp
        }
        vsp = -jump_speed
        djumps = 0
        has_airdodge = true
        has_walljump = false
    }
}

// wair
if (attack == AT_EXTRA_2) {
    walljump_extended_time = max(walljump_extended_time - 1, 0)
    if walljump_extended_time == 0 {
        vsp = wall_climb_speed_down
    } else {
        vsp = 0
    }
    if window == 3 && window_timer == get_window_value(AT_EXTRA_2, 3, AG_WINDOW_LENGTH) && jump_down{
        set_state(PS_WALL_JUMP)
        clinging = true
    }
}

// taunt cancel
if (attack == AT_TAUNT) {
    if window == 3 {
        if !taunt_down && window_timer == get_window_value(AT_TAUNT, 2, AG_WINDOW_LENGTH) {
            window++
            window_timer = 0
        }
    }
}

// Barney's extended sound engine! Pitch shift attack sounds!

if array_length_1d(attack_sound_grid[attack]) > 0 {
    var attack_sounds = attack_sound_grid[attack]
    for (i = 0; i < array_length_1d(attack_sounds); i++) {
        var sound = attack_sounds[i]
        if sound.window == window && sound.frame == window_timer && !hitpause {

            var sound_pitch = 1
            var sound_pitch_variation = 0
            var sound_volume = 1

            if variable_instance_exists(sound, "pitch") {
                sound_pitch = sound.pitch
            }

            if variable_instance_exists(sound, "pitch_variation") {
                sound_pitch_variation = sound.pitch_variation
            }

            if variable_instance_exists(sound, "volume") {
                sound_volume = sound.volume
            }

            var pitch_offset = (random_func(8, 2, false) - 1) * sound_pitch_variation
            
            // Room speed multiplier is a little easter egg if you slow the game down :3
            sound_play(sound.sound, false, noone, sound_volume, (sound_pitch + pitch_offset) * (room_speed / 60))
        }
    }
}