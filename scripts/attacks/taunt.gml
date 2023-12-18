set_attack_value(AT_TAUNT, AG_SPRITE, sprite_get("taunt"));
set_attack_value(AT_TAUNT, AG_NUM_WINDOWS, 4);
set_attack_value(AT_TAUNT, AG_HAS_LANDING_LAG, 3);
set_attack_value(AT_TAUNT, AG_OFF_LEDGE, 1);
set_attack_value(AT_TAUNT, AG_HURTBOX_SPRITE, asset_get("ex_guy_hurt_box"));

attack_sound_grid[AT_TAUNT] = [{
    window:2,
    frame:1,
    sound:asset_get("sfx_swipe_medium2"),
    pitch:1.2,
    pitch_variation:0
},
{
    window:2,
    frame:5,
    sound:asset_get("sfx_swipe_weak2"),
    pitch:1.6,
    pitch_variation:0
},
{
    window:2,
    frame:10,
    sound:asset_get("sfx_swipe_weak2"),
    pitch:1.4,
    pitch_variation:0
},
{
    window:3,
    frame:4,
    sound:asset_get("mfx_xp"),
    pitch:1.3,
    pitch_variation:0
},
{
    window:3,
    frame:32,
    sound:asset_get("mfx_xp"),
    pitch:1.1,
    pitch_variation:0
}]

// startup
set_window_value(AT_TAUNT, 1, AG_WINDOW_TYPE, 1);
set_window_value(AT_TAUNT, 1, AG_WINDOW_LENGTH, 12);
set_window_value(AT_TAUNT, 1, AG_WINDOW_ANIM_FRAMES, 2);
set_window_value(AT_TAUNT, 1, AG_WINDOW_ANIM_FRAME_START, 1);

// hat spawn
set_window_value(AT_TAUNT, 2, AG_WINDOW_TYPE, 1);
set_window_value(AT_TAUNT, 2, AG_WINDOW_LENGTH, 20);
set_window_value(AT_TAUNT, 2, AG_WINDOW_ANIM_FRAMES, 8);
set_window_value(AT_TAUNT, 2, AG_WINDOW_ANIM_FRAME_START, 3);

// hold
set_window_value(AT_TAUNT, 3, AG_WINDOW_TYPE, 9);
set_window_value(AT_TAUNT, 3, AG_WINDOW_LENGTH, 54);
set_window_value(AT_TAUNT, 3, AG_WINDOW_ANIM_FRAMES, 10);
set_window_value(AT_TAUNT, 3, AG_WINDOW_ANIM_FRAME_START, 10);

// endlag
set_window_value(AT_TAUNT, 4, AG_WINDOW_TYPE, 1);
set_window_value(AT_TAUNT, 4, AG_WINDOW_LENGTH, 4);
set_window_value(AT_TAUNT, 4, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_TAUNT, 4, AG_WINDOW_ANIM_FRAME_START, 21);
