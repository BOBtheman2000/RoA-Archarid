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