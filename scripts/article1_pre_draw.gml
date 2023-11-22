var tether_len = 0
var tether_dir = 0
var tether_colour = c_white

if tether_type == 'player' {
    var tether_to_y = tethered_player.y - tethered_player.char_height / 2

    tether_len = point_distance(x - 3, y - 3, tethered_player.x, tether_to_y)
    tether_dir = point_direction(x - 3, y - 3, tethered_player.x, tether_to_y)

    var tension_colour = (1 - tension_thresh) * 255

    tether_colour = make_colour_rgb(255, tension_colour, tension_colour)
}

if tether_type == 'orb' {
    tether_len = point_distance(x - 3, y - 3, tethered_orb.x, tethered_orb.y)
    tether_dir = point_direction(x - 3, y - 3, tethered_orb.x - 3, tethered_orb.y - 3)
}

draw_sprite_ext(web_line_sprite, 0, x, y, tether_len, 1, tether_dir, tether_colour, 1)