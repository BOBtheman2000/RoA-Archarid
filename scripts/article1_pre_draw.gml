// kill youreself

var tether_to_y = tethered_player.y - tethered_player.char_height / 2

var tether_len = point_distance(x - 3, y - 3, tethered_player.x, tether_to_y)
var tether_dir = point_direction(x - 3, y - 3, tethered_player.x, tether_to_y)

var tension_colour = (1 - tension) * 255

var tether_colour = make_colour_rgb(255, tension_colour, tension_colour)

draw_sprite_ext(web_line_sprite, 0, x, y, tether_len, 1, tether_dir, tether_colour, 1)