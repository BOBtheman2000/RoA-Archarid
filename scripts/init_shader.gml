if get_player_color(player) == 7 { //Remove EA skin shading
    for (i=0; i<6; i++) {
        set_character_color_shading( i, 0 );
    }
}