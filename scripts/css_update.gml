curr_skin = get_player_color(player)
lerp_skin = lerp(lerp_skin, curr_skin, 0.3)

if 'skin_change_time' in self {
    skin_change_time++

    if curr_skin != prev_skin {
        prev_skin = curr_skin
        skin_change_time = 0
    }
}