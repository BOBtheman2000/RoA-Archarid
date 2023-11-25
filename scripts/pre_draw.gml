if state == PS_WALL_JUMP {
    if clinging {
        if abs(wall_climbing) == 1 {
            sprite_index = wall_climb_sprite_down;
            if wall_climbing = -1 {
                sprite_index = wall_climb_sprite_up;
            }
            image_index = floor(((state_timer - walljump_extended_time) / 8) % 4);
        } else {
            sprite_index = wall_cling_sprite;
            image_index = state_timer < walljump_start_anim_time;
        }
    } else {
        var anim_timer = state_timer - walljump_leave_time;
        image_index = floor(anim_timer / 6) + 2;
    }
}
if state == PS_WALL_TECH {
    // yeah...
    image_index = floor(state_timer / (31/5)) + 2;
}

// fspecial lines
with (pHitBox) {
    if player_id == other && attack == AT_FSPECIAL && hbox_num = 1 {
        for (i=-1; i <= 1; i++) {
            var y_offset = i * 12
            var draw_len = point_distance(other.x + x_pos, other.y + y_pos, x, y)
            var draw_rot = point_direction(other.x + x_pos, other.y + y_pos, x, y + y_offset)
            draw_sprite_ext(player_id.web_line_sprite, 0, other.x + x_pos, other.y + y_pos, draw_len, 1, draw_rot, c_white, 1)
        }
    }
}

if attack == AT_FSPECIAL {

    if window == 3 {
        var x_player_offset = get_hitbox_value(AT_FSPECIAL, 1, HG_HITBOX_X)
        var y_player_offset = get_hitbox_value(AT_FSPECIAL, 1, HG_HITBOX_Y)

        var calc_x_pos = x + (x_player_offset * spr_dir)

        for (i=-1; i <= 1; i++) {
            var y_offset = i * 12
            var draw_len = point_distance(calc_x_pos, y + y_player_offset, fspecial_target_x, fspecial_target_y)
            var draw_rot = point_direction(calc_x_pos, y + y_player_offset, fspecial_target_x, fspecial_target_y + y_player_offset + y_offset)

            draw_len *= 1 - (window_timer / get_window_value(AT_FSPECIAL, 3, AG_WINDOW_LENGTH))

            draw_sprite_ext(web_line_sprite, 0, calc_x_pos, y + y_player_offset, draw_len, 1, draw_rot, c_white, 1)
        }
    } else if window >= 2 {

        if instance_exists(fspecial_target_player) {
            var x_player_offset = get_hitbox_value(AT_FSPECIAL, 1, HG_HITBOX_X)
            var y_player_offset = get_hitbox_value(AT_FSPECIAL, 1, HG_HITBOX_Y)

            var calc_x_pos = x + (x_player_offset * spr_dir)

            for (i=-1; i <= 1; i++) {
                var y_offset = i * 12
                var draw_len = point_distance(calc_x_pos, y + y_player_offset, fspecial_target_player.x, fspecial_target_player.y)
                var draw_rot = point_direction(calc_x_pos, y + y_player_offset, fspecial_target_player.x, fspecial_target_player.y + y_player_offset + y_offset)

                if window == 5 {
                    draw_len *= 1 - (window_timer / get_window_value(AT_FSPECIAL, 5, AG_WINDOW_LENGTH))
                }

                draw_sprite_ext(web_line_sprite, 0, calc_x_pos, y + y_player_offset, draw_len, 1, draw_rot, c_white, 1)
            }
        } else if window == 4 {
            var x_player_offset = get_hitbox_value(AT_FSPECIAL, 1, HG_HITBOX_X)
            var y_player_offset = get_hitbox_value(AT_FSPECIAL, 1, HG_HITBOX_Y)

            var calc_x_pos = x + (x_player_offset * spr_dir)

            for (i=-1; i <= 1; i++) {
                var y_offset = i * 12
                var draw_len = point_distance(calc_x_pos, y + y_player_offset, fspecial_target_x, fspecial_target_y)
                var draw_rot = point_direction(calc_x_pos, y + y_player_offset, fspecial_target_x, fspecial_target_y + y_player_offset + y_offset)

                draw_sprite_ext(web_line_sprite, 0, calc_x_pos, y + y_player_offset, draw_len, 1, draw_rot, c_white, 1)
            }
        }

    }
}