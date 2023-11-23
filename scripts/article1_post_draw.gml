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