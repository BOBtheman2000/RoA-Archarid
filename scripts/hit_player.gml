if attack == AT_DSPECIAL {
    if barney_archarid_tethered_to_orb {
        barney_archarid_current_orb.tethered_player = hit_player_obj
        barney_archarid_tethered_to_orb = false
        with (hit_player_obj) {
            barney_archarid_tethered_to_orb = true
        }
    }
}