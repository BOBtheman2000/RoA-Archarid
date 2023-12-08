shader_start()

// this should probably be in animation whoOPS
if state == PS_WALL_JUMP {
    if clinging {
        if abs(wall_climbing) == 1 {
            sprite_index = wall_climb_sprite_down;
            if wall_climbing = -1 {
                sprite_index = wall_climb_sprite_up;
            }
            image_index = floor(((state_timer - walljump_extended_time) / 4) % (4 - wall_climbing * 2));
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

var draw_hbox_lines = false

with (pHitBox) {
    if player_id == other && attack == AT_FSPECIAL && hbox_num = 1 {
        draw_hbox_lines = true
        for (i=-1; i <= 1; i++) {
            var y_offset = i * 12
            var draw_len = point_distance(other.x + x_pos, other.y + y_pos, x, y)
            var draw_rot = point_direction(other.x + x_pos, other.y + y_pos, x, y + y_offset)
            draw_sprite_ext(player_id.web_line_sprite, 1, other.x + x_pos, other.y + y_pos, draw_len, 1, draw_rot, c_white, 1)
        }
    }
}

if (state == PS_ATTACK_GROUND || state == PS_ATTACK_AIR) && attack == AT_FSPECIAL {
    if window > 1 && !draw_hbox_lines {

        var x_player_offset = get_hitbox_value(AT_FSPECIAL, 1, HG_HITBOX_X)
        var y_player_offset = get_hitbox_value(AT_FSPECIAL, 1, HG_HITBOX_Y)

        var target_x = fspecial_target_x
        var target_y = fspecial_target_y

        if instance_exists(fspecial_target_player) {
            target_x = fspecial_target_player.x
            target_y = fspecial_target_player.y + y_player_offset
        }

        var calc_x_pos = x + (x_player_offset * spr_dir)

        for (i=-1; i <= 1; i++) {
            var x_offset = 0
            var y_offset = i * 12

            if fspecial_draw_angle_override {
                if i < 0 {
                    x_offset = fspecial_bottom_draw_override_x
                    y_offset = fspecial_bottom_draw_override_y
                }
                if i > 0 {
                    x_offset = fspecial_top_draw_override_x
                    y_offset = fspecial_top_draw_override_y
                }
            }

            var draw_len = point_distance(calc_x_pos, y + y_player_offset, target_x + x_offset, target_y + y_offset)
            var draw_rot = point_direction(calc_x_pos, y + y_player_offset, target_x + x_offset, target_y + y_offset)

            if window == 3 {
                draw_len *= max(0, 1 - ease_expoIn(0, 1, window_timer, floor(get_window_value(AT_FSPECIAL, 3, AG_WINDOW_LENGTH) / 3)))
            } else if window == 5 {
                draw_len *= max(0, 1 - ease_expoIn(0, 1, window_timer, floor(get_window_value(AT_FSPECIAL, 5, AG_WINDOW_LENGTH) / 3)))
            }

            draw_sprite_ext(web_line_sprite, 1, calc_x_pos, y + y_player_offset, draw_len, 1, draw_rot, c_white, 1)
        }
    }
}

shader_end()