shader_end()

var hud_x = x + 35
var hud_y = y + 152

var hud_alpha = 1 + ((hud_decay_start - clamp(skin_change_time, hud_decay_start, hud_decay_end)) / (hud_decay_end - hud_decay_start))

var pip_spr_height = 6

var pip_range = 3

for (i=0; i < skin_count; i++) {

    var pip_height = ease_sineOut(1, 0, min(pip_range*100, floor(abs(lerp_skin - i) * 100)), pip_range*100)

    var x_offset = i * pip_width / skin_count
    var y_offset = -pip_height * (pip_spr_height*2)

    draw_sprite_part_ext(tab_sprite, 0, 0, 0, 3, y_offset/-2, hud_x + x_offset, hud_y + y_offset, 2, 2, c_white, hud_alpha)
}

draw_set_font(asset_get('fName'))

var bg_font_col = c_black

var text_x_off = 0
var text_y_off = -14

var text_shade = make_color_rgb(
    get_color_profile_slot_r(curr_skin, 0),
    get_color_profile_slot_g(curr_skin, 0),
    get_color_profile_slot_b(curr_skin, 0)
)

draw_text_colour(hud_x + text_x_off, hud_y + text_y_off - 2, skin_titles[curr_skin], bg_font_col, bg_font_col, bg_font_col, bg_font_col, hud_alpha)
draw_text_colour(hud_x + text_x_off, hud_y + text_y_off + 2, skin_titles[curr_skin], bg_font_col, bg_font_col, bg_font_col, bg_font_col, hud_alpha)
draw_text_colour(hud_x + text_x_off - 2, hud_y + text_y_off, skin_titles[curr_skin], bg_font_col, bg_font_col, bg_font_col, bg_font_col, hud_alpha)
draw_text_colour(hud_x + text_x_off + 2, hud_y + text_y_off, skin_titles[curr_skin], bg_font_col, bg_font_col, bg_font_col, bg_font_col, hud_alpha)
draw_text_colour(hud_x + text_x_off, hud_y + text_y_off, skin_titles[curr_skin], text_shade, c_white, c_white, text_shade, hud_alpha)