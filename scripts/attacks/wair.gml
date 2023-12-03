set_attack_value(AT_EXTRA_2, AG_CATEGORY, 1);
set_attack_value(AT_EXTRA_2, AG_SPRITE, sprite_get("wair"));
set_attack_value(AT_EXTRA_2, AG_NUM_WINDOWS, 3);
set_attack_value(AT_EXTRA_2, AG_HAS_LANDING_LAG, 1);
set_attack_value(AT_EXTRA_2, AG_LANDING_LAG, 4);
set_attack_value(AT_EXTRA_2, AG_HURTBOX_SPRITE, sprite_get("uair_hurt"));

attack_sound_grid[AT_EXTRA_2] = [{
    window:1,
    frame:4,
    sound:asset_get("sfx_swipe_medium1"),
    pitch:3.2,
    pitch_variation:0.2
}]

// startup
set_window_value(AT_EXTRA_2, 1, AG_WINDOW_TYPE, 1);
set_window_value(AT_EXTRA_2, 1, AG_WINDOW_LENGTH, 4);
set_window_value(AT_EXTRA_2, 1, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_EXTRA_2, 1, AG_WINDOW_ANIM_FRAME_START, 1);

// active
set_window_value(AT_EXTRA_2, 2, AG_WINDOW_TYPE, 1);
set_window_value(AT_EXTRA_2, 2, AG_WINDOW_LENGTH, 4);
set_window_value(AT_EXTRA_2, 2, AG_WINDOW_ANIM_FRAMES, 2);
set_window_value(AT_EXTRA_2, 2, AG_WINDOW_ANIM_FRAME_START, 2);

// endlag
set_window_value(AT_EXTRA_2, 3, AG_WINDOW_TYPE, 1);
set_window_value(AT_EXTRA_2, 3, AG_WINDOW_LENGTH, 6);
set_window_value(AT_EXTRA_2, 3, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_EXTRA_2, 3, AG_WINDOW_ANIM_FRAME_START, 3);
set_window_value(AT_EXTRA_2, 3, AG_WINDOW_HAS_WHIFFLAG, 4);

set_num_hitboxes(AT_EXTRA_2, 1);

hit_sound_grid[AT_EXTRA_2] = [{
    hitbox:1,
    sound:asset_get("sfx_blow_medium2"),
    pitch:1.0,
    pitch_variation:0.1
},
{
    hitbox:1,
    sound:asset_get("sfx_may_whip2"),
    pitch:2.4,
    pitch_variation:0.2
}]

set_hitbox_value(AT_EXTRA_2, 1, HG_PARENT_HITBOX, 1);
set_hitbox_value(AT_EXTRA_2, 1, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_EXTRA_2, 1, HG_WINDOW, 2);
set_hitbox_value(AT_EXTRA_2, 1, HG_LIFETIME, 3);
set_hitbox_value(AT_EXTRA_2, 1, HG_HITBOX_X, 10);
set_hitbox_value(AT_EXTRA_2, 1, HG_HITBOX_Y, -35);
set_hitbox_value(AT_EXTRA_2, 1, HG_WIDTH, 80);
set_hitbox_value(AT_EXTRA_2, 1, HG_HEIGHT, 65);
set_hitbox_value(AT_EXTRA_2, 1, HG_PRIORITY, 1);
set_hitbox_value(AT_EXTRA_2, 1, HG_DAMAGE, 4);
set_hitbox_value(AT_EXTRA_2, 1, HG_ANGLE, 60);
set_hitbox_value(AT_EXTRA_2, 1, HG_BASE_KNOCKBACK, 7);
set_hitbox_value(AT_EXTRA_2, 1, HG_KNOCKBACK_SCALING, .8);
set_hitbox_value(AT_EXTRA_2, 1, HG_BASE_HITPAUSE, 8);
set_hitbox_value(AT_EXTRA_2, 1, HG_HITPAUSE_SCALING, .8);
set_hitbox_value(AT_EXTRA_2, 1, HG_VISUAL_EFFECT_Y_OFFSET, -16);
set_hitbox_value(AT_EXTRA_2, 1, HG_VISUAL_EFFECT, web_hit_vfx_small);