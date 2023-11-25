var tether_len = 0
var tether_dir = 0
var tether_colour = c_white

draw_sprite(back_sprite, min(2, floor(lifetime / 4)), x, y)

if instance_exists(tethered_player) {
    var tether_to_y = tethered_player.y - tethered_player.char_height / 2

    tether_len = point_distance(x, y, tethered_player.x, tether_to_y)
    tether_dir = point_direction(x, y, tethered_player.x, tether_to_y)

    var tension_colour = (1 - tension_thresh) * 255

    tether_colour = make_colour_rgb(255, tension_colour, tension_colour)

    draw_sprite_ext(web_line_sprite, 0, x, y, tether_len, 1, tether_dir, tether_colour, 1)
}

for (i=0; i < array_length_1d(tethered_orbs); i++) {
    if !tethered_orbs[i].parent {
        continue
    }

    var source_orb = id

    var orb_data = tethered_orbs[i]

    var tethered_orb = orb_data.target

    if orb_data.jumping_state_timer <= 0 {
        tether_len = point_distance(x, y, tethered_orb.x, tethered_orb.y)
        tether_dir = point_direction(x, y, tethered_orb.x, tethered_orb.y)

        draw_sprite_ext(web_line_sprite, 0, x, y, tether_len, 1, tether_dir, tether_colour, 1)
    } else {
        tether_len = point_distance(x, y, orb_data.jump_midpoint_x, orb_data.jump_midpoint_y)
        tether_dir = point_direction(x, y, orb_data.jump_midpoint_x, orb_data.jump_midpoint_y) + 2
        draw_sprite_ext(web_line_sprite, 0, x, y, tether_len, 1, tether_dir, tether_colour, 1)

        tether_len = point_distance(tethered_orb.x, tethered_orb.y, orb_data.jump_midpoint_x, orb_data.jump_midpoint_y)
        tether_dir = point_direction(tethered_orb.x, tethered_orb.y, orb_data.jump_midpoint_x, orb_data.jump_midpoint_y) + 2
        draw_sprite_ext(web_line_sprite, 0, tethered_orb.x, tethered_orb.y, tether_len, 1, tether_dir, tether_colour, 1)
    }
}