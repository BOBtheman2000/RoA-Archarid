// instantiating other variables
with (oPlayer) {
    if "barney_archarid_yes" not in self {
        barney_archarid_yes = false
        barney_archarid_tethered_to_orb = false
        barney_archarid_current_orb = 0
        barney_archarid_airtime_jumps = 0
    }
    if !free {
        barney_archarid_airtime_jumps = 0
    }
}

if barney_archarid_tethered_to_orb && !instance_exists(barney_archarid_current_orb) {
    phantom_tethered = false
    barney_archarid_tethered_to_orb = false
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

// cooldown behavior
if !free {
    move_cooldown[AT_DSPECIAL] = 0
    move_cooldown[AT_USPECIAL] = 0
} else {
    move_cooldown[AT_DSPECIAL] = move_cooldown[AT_DSPECIAL] + 1
    move_cooldown[AT_USPECIAL] = move_cooldown[AT_USPECIAL] + 1
}

// Wallcling/Climbing behavior
if state == PS_WALL_JUMP {
    move_cooldown[AT_USPECIAL] = 0
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

if has_rune("E") {
    outline_color[1] = max(outline_color[1] - 10, 0)
    init_shader()
}

if has_rune("J") {
    if phantom_tether_interrupt {
        clear_button_buffer(PC_SPECIAL_PRESSED)
        set_state(PS_IDLE_AIR)
        attack_end()
        phantom_tethered = true
        phantom_tether_interrupt = false
    } else if !barney_archarid_tethered_to_orb {
        phantom_tethered = false
    }
} else {
    phantom_tether_interrupt = false
    phantom_tethered = false
}