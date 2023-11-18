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
            var pitch_offset = (random_func(8, 2, false) - 1) * sound.pitch_variation
            sound_play(sound.sound, false, false, 1, sound.pitch + pitch_offset)
        }
    }
}