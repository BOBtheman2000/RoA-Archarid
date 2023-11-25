
if attack == AT_FSPECIAL && hbox_num == 1 {

    var queue_free = false

    player_id.fspecial_target_x = x
    player_id.fspecial_target_y = y

    hsp -= 1 * spr_dir
    if sign(hsp) != spr_dir {
        if place_meeting(x, y, player_id) {
            queue_free = true
        } else {
            if player_id.window == 2 {
                player_id.window++
                player_id.window_timer = 0
                queue_free = true
            }
        }
    }

    if place_meeting(x - hsp, y - vsp, asset_get("par_block")) {
        player_id.fspecial_found_target = true
        player_id.fspecial_target_player = noone
        queue_free = true
        sound_play(player_id.web_line_snap_sound, false, noone, 1, 2.2)
    }

    if queue_free {
        instance_destroy()
    }

}