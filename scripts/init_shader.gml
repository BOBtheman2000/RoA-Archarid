if get_player_color(player) == 7 { // Remove EA skin shading
    for (i=0; i<6; i++) {
        set_character_color_shading( i, 0 );
    }
} else if get_player_color(player) == 9 { // Superbuff shading on the ms tarantula skin
    set_character_color_shading( 0, 3 );
    set_character_color_shading( 1, 2 );
} else if get_player_color(player) != 1 && get_player_color(player) != 22 { // Improve shading for everything else
    // I noticed a little too late that the shading on archarid was, really weak
    // So I'm fixing it in code! Fuck you!
    set_character_color_shading( 0, 2 );
    set_character_color_shading( 1, 2 );
}