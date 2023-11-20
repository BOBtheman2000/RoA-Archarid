if attack == AT_DSPECIAL {
    if barney_archarid_tethered_to_orb {
        barney_archarid_current_orb.tethered_player = hit_player_obj
        barney_archarid_tethered_to_orb = false
        with (hit_player_obj) {
            barney_archarid_tethered_to_orb = true
        }
    }
}

// Barney's extended sound engine! Pitch shift sounds in realtime!

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
            sound_play(sound.sound, false, false, sound_volume, (sound_pitch + pitch_offset) * (room_speed / 60))
        }
    }
}