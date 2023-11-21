// Wallcling/Climbing behavior
if state == PS_WALL_JUMP {
    if state_timer == walljump_start_anim_time + 2 && walljump_extended_time > 0 {
        state_timer--;
        walljump_extended_time--;
    }

    if clinging {
        if up_down {
            vsp = wall_climb_speed_up;
            wall_climbing = -1;
        }
        else if down_down {
            vsp = wall_climb_speed_down;
            wall_climbing = 1;
        }
        else {
            wall_climbing = 0;
        }
    }

    if !clinging && walljump_leave_time == 0 {
        walljump_leave_time = state_timer;
    }
} else {
    walljump_leave_time = 0;
    walljump_extended_time = walljump_extended_time_default;
}