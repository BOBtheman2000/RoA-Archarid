with (pHitBox) {
    if player_id == other && attack == AT_FSPECIAL && hbox_num == 1 {
        instance_destroy()
    }
}