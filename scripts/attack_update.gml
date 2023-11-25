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
        if (!attack_down) {
            window++;
        }
    }
}

// sandbert
if (attack == AT_NSPECIAL){
    if (window == 3){
        if (special_pressed){
            window = 1;
            window_timer = 0;
        }
    }
}

// sandbert
if (attack == AT_FSPECIAL){
    if (window == 2){
        if (special_pressed){
            window = 3;
            window_timer = 0;
            destroy_hitboxes();
        }
    }
    can_fast_fall = false;
}

// sandbert
if (attack == AT_USPECIAL){
    if (window == 1 && window_timer == 1){
        times_through = 0;
    }
    if (window == 2){
        if (window_timer == get_window_value(attack, 2, AG_WINDOW_LENGTH)){
            if (times_through < 10){
                times_through++;
                window_timer = 0;
            }
        }
        if (!joy_pad_idle){
            hsp += lengthdir_x(1, joy_dir);
            vsp += lengthdir_y(1, joy_dir);
        } else {
            hsp *= .6;
            vsp *= .6;
        }
        var fly_dir = point_direction(0,0,hsp,vsp);
        var fly_dist = point_distance(0,0,hsp,vsp);
        var max_speed = 12;
        if (fly_dist > max_speed){
            hsp = lengthdir_x(max_speed, fly_dir);
            vsp = lengthdir_y(max_speed, fly_dir);
        }
        if (special_pressed && times_through > 0){
            window = 4;
            window_timer = 0;
        }
        if (shield_pressed){
            window = 3;
            window_timer = 0;
        }
    }
    if (window > 3 && window < 6 && window_timer == get_window_value(attack, window, AG_WINDOW_LENGTH)){
        window++;
        window_timer = 0;
    }
}

// Down special
if (attack == AT_DSPECIAL){
    if window == 1 {
        if window_timer == 16 && (special_down && free) {
            window_timer--
        }
    }
    if window == 2 {
        if window_timer == 0 && !free {
            // these need to be mocked because of window 8 behavior
            hsp = get_window_value(AT_DSPECIAL, 2, AG_WINDOW_HSPEED) * spr_dir
            vsp = get_window_value(AT_DSPECIAL, 2, AG_WINDOW_VSPEED)
        }
    }
    if window == 3 {
        if window_timer == 1 && !hitstop && has_hit == false && has_hit_player = false {
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

                // we should always be assigning the parent role to the newest orb so draw order doesn't get muddled
                array_push(new_orb.tethered_orb_queue, barney_archarid_current_orb)
                sound_play(web_point_spawn_sound, false, noone, 1, 2)
            }
        }
    }
    can_fast_fall = false;
    can_move = false
}

// Barney's extended sound engine! Pitch shift attack sounds!

if array_length_1d(attack_sound_grid[attack]) > 0 {
    var attack_sounds = attack_sound_grid[attack]
    for (i = 0; i < array_length_1d(attack_sounds); i++) {
        var sound = attack_sounds[i]
        if sound.window == window && sound.frame == window_timer {

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