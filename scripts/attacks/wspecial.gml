set_attack_value(AT_EXTRA_1, AG_CATEGORY, 1);
set_attack_value(AT_EXTRA_1, AG_SPRITE, sprite_get("wspecial"));
set_attack_value(AT_EXTRA_1, AG_NUM_WINDOWS, 2);
set_attack_value(AT_EXTRA_1, AG_HURTBOX_SPRITE, sprite_get("wspecial_hurt"));

attack_sound_grid[AT_EXTRA_1] = [{
    window:2,
    frame:1,
    sound:asset_get("sfx_land_light"),
    pitch:1.8,
    pitch_variation:0.2
},
{
    window:2,
    frame:5,
    sound:asset_get("sfx_land_light"),
    pitch:1.8,
    pitch_variation:0.2
}]

// startup
set_window_value(AT_EXTRA_1, 1, AG_WINDOW_TYPE, 1);
set_window_value(AT_EXTRA_1, 1, AG_WINDOW_LENGTH, 16);
set_window_value(AT_EXTRA_1, 1, AG_WINDOW_ANIM_FRAMES, 2);
set_window_value(AT_EXTRA_1, 1, AG_WINDOW_HSPEED_TYPE, 1);
set_window_value(AT_EXTRA_1, 1, AG_WINDOW_VSPEED_TYPE, 1);

// run!
set_window_value(AT_EXTRA_1, 2, AG_WINDOW_TYPE, 9);
set_window_value(AT_EXTRA_1, 2, AG_WINDOW_LENGTH, 8);
set_window_value(AT_EXTRA_1, 2, AG_WINDOW_ANIM_FRAMES, 4);
set_window_value(AT_EXTRA_1, 2, AG_WINDOW_ANIM_FRAME_START, 2);
set_window_value(AT_EXTRA_1, 2, AG_WINDOW_HSPEED, 0);
set_window_value(AT_EXTRA_1, 2, AG_WINDOW_VSPEED, -12);
set_window_value(AT_EXTRA_1, 2, AG_WINDOW_HSPEED_TYPE, 1);
set_window_value(AT_EXTRA_1, 2, AG_WINDOW_VSPEED_TYPE, 1);

set_num_hitboxes(AT_EXTRA_1, has_rune("A") ? 1 : 0);

// rune

hit_sound_grid[AT_EXTRA_1] = [{
    hitbox:1,
    sound:asset_get("sfx_blow_heavy2"),
    pitch:1.2,
    pitch_variation:0.1
}]

set_hitbox_value(AT_EXTRA_1, 1, HG_PARENT_HITBOX, 1);
set_hitbox_value(AT_EXTRA_1, 1, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_EXTRA_1, 1, HG_WINDOW, 2);
set_hitbox_value(AT_EXTRA_1, 1, HG_LIFETIME, 7);
set_hitbox_value(AT_EXTRA_1, 1, HG_HITBOX_X, 0);
set_hitbox_value(AT_EXTRA_1, 1, HG_HITBOX_Y, -40);
set_hitbox_value(AT_EXTRA_1, 1, HG_WIDTH, 40);
set_hitbox_value(AT_EXTRA_1, 1, HG_HEIGHT, 40);
set_hitbox_value(AT_EXTRA_1, 1, HG_SHAPE, 1);
set_hitbox_value(AT_EXTRA_1, 1, HG_PRIORITY, 2);
set_hitbox_value(AT_EXTRA_1, 1, HG_DAMAGE, 6);
set_hitbox_value(AT_EXTRA_1, 1, HG_ANGLE, 80);
set_hitbox_value(AT_EXTRA_1, 1, HG_BASE_KNOCKBACK, 7);
set_hitbox_value(AT_EXTRA_1, 1, HG_KNOCKBACK_SCALING, .8);
set_hitbox_value(AT_EXTRA_1, 1, HG_BASE_HITPAUSE, 12);
set_hitbox_value(AT_EXTRA_1, 1, HG_HITPAUSE_SCALING, .8);
set_hitbox_value(AT_EXTRA_1, 1, HG_VISUAL_EFFECT, space_hit_vfx);