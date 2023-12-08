// instantiating other variables
with (oPlayer) {
    if "barney_archarid_yes" not in self {
        barney_archarid_yes = false
        barney_archarid_tethered_to_orb = false
        barney_archarid_current_orb = 0
    }
}

if rapid_jab_timer > 0 {
    rapid_jab_timer--
}

if attack_pressed {
    rapid_jab_timer = 16
}

// undo uspecial override
if barney_archarid_tethered_to_orb && ((state != PS_ATTACK_GROUND && state != PS_ATTACK_AIR) || attack != AT_USPECIAL) {
    barney_archarid_current_orb.override_all = false
}

// dspecial cooldown behavior
if !free {
    move_cooldown[AT_DSPECIAL] = 0
} else {
    move_cooldown[AT_DSPECIAL] = move_cooldown[AT_DSPECIAL] + 1
}

// Wallcling/Climbing behavior
if state == PS_WALL_JUMP {
    if state_timer == walljump_start_anim_time + 2 && walljump_extended_time > 0 {
        state_timer--;
        walljump_extended_time--;
    }

    if clinging {

        if walljump_extended_time == 0 {
            state_timer = ((state_timer - walljump_start_anim_time) % 8) + walljump_start_anim_time
        }

        var check_wall_x = x + (-40 * spr_dir)
        var check_wall_y_up = y - 60
        var check_wall_y_down = y + 20

        var available_up = collision_point(check_wall_x, check_wall_y_up, asset_get("par_block"), false, true) != noone
        var available_down = collision_point(check_wall_x, check_wall_y_down, asset_get("par_block"), false, true) != noone

        if up_down && available_up && walljump_extended_time > 0 {
            vsp = wall_climb_speed_up;
            wall_climbing = -1;
        }
        else if (down_down && available_down) || walljump_extended_time == 0 {
            vsp = wall_climb_speed_down;
            wall_climbing = 1;
        }
        else {
            wall_climbing = 0;
        }

        // wspecial
        if special_pressed {
            set_attack(AT_EXTRA_1)
        }

        // wair
        if attack_pressed {
            set_attack(AT_EXTRA_2)
        }

    }

    if !clinging && walljump_leave_time == 0 {
        walljump_leave_time = state_timer;
    }
} else {
    walljump_leave_time = 0;
    if state != PS_ATTACK_AIR || attack != AT_EXTRA_2 {
        walljump_extended_time = walljump_extended_time_default;
    }
}