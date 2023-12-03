var target_draw_x = 0
var target_draw_y = 0

for (i=0; i<array_length_1d(tether_list); i++) {
    target_draw_x += lengthdir_x(8, tether_list[i])
    target_draw_y += lengthdir_y(8, tether_list[i])
}

target_draw_x = clamp(target_draw_x, -10, 10)
target_draw_y = clamp(target_draw_y, -10, 10)

draw_x = lerp(draw_x, target_draw_x, 0.6)
draw_y = lerp(draw_y, target_draw_y, 0.6)

draw_sprite(real_sprite_index, real_image_index, x + draw_x, y + draw_y)
if doing_hurt_animation {
    draw_sprite_ext(flash_sprite, 0, x + draw_x, y + draw_y, 1, 1, 0, c_white, (1/1.5) - ((hurt_animation_timer / hurt_animation_time)/1.5))
}

var offscreen_pos_x = x
var offscreen_pos_y = y
var offscreen_rot = -1

var offscreen_offset = 40

var draw_h = 0
var draw_v = 0

if x < view_get_xview() {
    draw_h = -1
    offscreen_pos_x = view_get_xview() + offscreen_offset
    offscreen_rot = 0
} else if x > view_get_xview() + view_get_wview() {
    draw_h = 1
    offscreen_pos_x = view_get_xview() + view_get_wview() - offscreen_offset
    offscreen_rot = 180
}

if y < view_get_yview() {
    draw_v = -1
    offscreen_pos_y = view_get_yview() + offscreen_offset
    if offscreen_rot == -1 {
        offscreen_rot = 270
    } else if offscreen_rot == 0 {
        offscreen_rot = -45
    } else {
        offscreen_rot = 225
    }
} else if y > view_get_yview() + view_get_hview() {
    draw_v = 1
    offscreen_pos_y = view_get_yview() + view_get_hview() - offscreen_offset
    if offscreen_rot == -1 {
        offscreen_rot = 90
    } else if offscreen_rot == 0 {
        offscreen_rot = 45
    } else {
        offscreen_rot = 135
    }
}

if abs(draw_h) == 1 || abs(draw_v) == 1 {

    draw_h = ((draw_h == 0) ? draw_v : draw_h)
    draw_v = ((draw_v == 0) ? -draw_h : draw_v)

    draw_sprite_ext(asset_get('offscreen_cloud_bg_spr'), 0, offscreen_pos_x, offscreen_pos_y, 1, 1, offscreen_rot, get_player_hud_color(player_id.player), 1)
    draw_sprite_ext(offscreen_sprite, 0, offscreen_pos_x - draw_h, offscreen_pos_y - draw_v, 1, 1, 0, c_white, 1)
}