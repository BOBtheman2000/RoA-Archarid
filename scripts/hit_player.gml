if attack == AT_DSPECIAL {
    
    if !hit_player_obj.barney_archarid_tethered_to_orb {

        if !barney_archarid_tethered_to_orb {
            hit_player_obj.barney_archarid_current_orb = instance_create(x, y, "obj_article1");
            sound_play(web_point_spawn_sound, false, noone, 1, 2)
        } else {
            barney_archarid_current_orb.tether_snap_lockout = true
            hit_player_obj.barney_archarid_current_orb = barney_archarid_current_orb
        }
        barney_archarid_tethered_to_orb = false
        with (hit_player_obj) {
            barney_archarid_tethered_to_orb = true
            barney_archarid_current_orb.tethered_player = id
        }

    } else {

        if !barney_archarid_tethered_to_orb {

            barney_archarid_tethered_to_orb = true
            barney_archarid_current_orb = hit_player_obj.barney_archarid_current_orb
            sound_play(web_point_spawn_sound, false, noone, 1, 2)

            with (hit_player_obj) {
                barney_archarid_tethered_to_orb = false
                barney_archarid_current_orb.tethered_player = other
                barney_archarid_current_orb.tether_snap_lockout = true
            }

        } else {

            barney_archarid_tethered_to_orb = false
            hit_player_obj.barney_archarid_tethered_to_orb = false
            array_push(barney_archarid_current_orb.tethered_orb_queue, hit_player_obj.barney_archarid_current_orb)

            barney_archarid_current_orb.tethered_player = noone
            hit_player_obj.barney_archarid_current_orb.tethered_player = noone

        }

    }
}

// Barney's extended sound engine! Pitch shift hit sounds!

if array_length_1d(hit_sound_grid[my_hitboxID.attack]) > 0 {
    var attack_sounds = hit_sound_grid[my_hitboxID.attack]
    for (i = 0; i < array_length_1d(attack_sounds); i++) {
        var sound = attack_sounds[i]
        if sound.hitbox == my_hitboxID.hbox_num {

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