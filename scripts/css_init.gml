sound_play(asset_get("sfx_may_whip2"), false, false, 1, 2.4)

curr_skin = get_player_color(player)
prev_skin = curr_skin
lerp_skin = curr_skin

skin_change_time = 0
hud_decay_start = 180
hud_decay_end = 240

pip_width = 148

tab_sprite = sprite_get('css_pip')

skin_count = 27
skin_titles = [
    'Default',
    'Blue',
    'Red',
    'Green',
    'Grey',
    'Purple',
    'Abyss',
    'Early Access',
    'Violence',
    'Bad Guy',
    'Aussie',
    'Synnesthesiac',
    'Pretty in Pink',
    'Psionic',
    'Friendly Neighbourhood',
    'Beyond Binary',
    'Strawberries n Cream',
    'Justicar',
    'Forest Gremlin',
    'Nut Bush Haver',
    "Neon Genesis Evangelion
or something I haven't
seen the show",
    "Enigma",
    "Cookies & Cream",
    "Cream & Cookies",
    'Blackpink',
    'Electric Feel',
    'Coldhearted'
]