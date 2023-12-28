set_attack_value(AT_DAIR, AG_CATEGORY, 1);
set_attack_value(AT_DAIR, AG_SPRITE, sprite_get("dair"));
set_attack_value(AT_DAIR, AG_NUM_WINDOWS, 3);
set_attack_value(AT_DAIR, AG_HAS_LANDING_LAG, 1);
set_attack_value(AT_DAIR, AG_LANDING_LAG, 4);
set_attack_value(AT_DAIR, AG_HURTBOX_SPRITE, sprite_get("dair_hurt"));

attack_sound_grid[AT_DAIR] = [{
    window:1,
    frame:14,
    sound:asset_get("sfx_swipe_heavy2"),
    pitch:1.2,
    pitch_variation:0.2
}]

// startup
set_window_value(AT_DAIR, 1, AG_WINDOW_TYPE, 1);
set_window_value(AT_DAIR, 1, AG_WINDOW_LENGTH, 14);
set_window_value(AT_DAIR, 1, AG_WINDOW_ANIM_FRAMES, 3);

// active
set_window_value(AT_DAIR, 2, AG_WINDOW_TYPE, 1);
set_window_value(AT_DAIR, 2, AG_WINDOW_LENGTH, 6);
set_window_value(AT_DAIR, 2, AG_WINDOW_ANIM_FRAMES, 2);
set_window_value(AT_DAIR, 2, AG_WINDOW_ANIM_FRAME_START, 3);

// endlag
set_window_value(AT_DAIR, 3, AG_WINDOW_TYPE, 1);
set_window_value(AT_DAIR, 3, AG_WINDOW_LENGTH, 12);
set_window_value(AT_DAIR, 3, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_DAIR, 3, AG_WINDOW_ANIM_FRAME_START, 5);
set_window_value(AT_DAIR, 3, AG_WINDOW_HAS_WHIFFLAG, true);

set_num_hitboxes(AT_DAIR, 2);

hit_sound_grid[AT_DAIR] = [{
    hitbox:1,
    sound:asset_get("sfx_blow_heavy2"),
    pitch:1.2,
    pitch_variation:0.1
},
{
    hitbox:2,
    sound:asset_get("sfx_may_whip2"),
    pitch:1.2,
    pitch_variation:0.1
}]

// sweet
set_hitbox_value(AT_DAIR, 1, HG_PARENT_HITBOX, 1);
set_hitbox_value(AT_DAIR, 1, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_DAIR, 1, HG_WINDOW, 2);
set_hitbox_value(AT_DAIR, 1, HG_LIFETIME, 3);
set_hitbox_value(AT_DAIR, 1, HG_HITBOX_X, 14);
set_hitbox_value(AT_DAIR, 1, HG_HITBOX_Y, -3);
set_hitbox_value(AT_DAIR, 1, HG_WIDTH, 40);
set_hitbox_value(AT_DAIR, 1, HG_HEIGHT, 75);
set_hitbox_value(AT_DAIR, 1, HG_SHAPE, 0);
set_hitbox_value(AT_DAIR, 1, HG_PRIORITY, 1);
set_hitbox_value(AT_DAIR, 1, HG_DAMAGE, 12);
set_hitbox_value(AT_DAIR, 1, HG_ANGLE, 250);
set_hitbox_value(AT_DAIR, 1, HG_BASE_KNOCKBACK, 8);
set_hitbox_value(AT_DAIR, 1, HG_KNOCKBACK_SCALING, 0.8);
set_hitbox_value(AT_DAIR, 1, HG_BASE_HITPAUSE, 8);
set_hitbox_value(AT_DAIR, 1, HG_HITPAUSE_SCALING, 1.0);
set_hitbox_value(AT_DAIR, 1, HG_VISUAL_EFFECT, space_hit_vfx);
set_hitbox_value(AT_DAIR, 1, HG_VISUAL_EFFECT_Y_OFFSET, 20);

// sour
if has_rune("D") {

    hit_sound_grid[AT_DAIR] = [{
        hitbox:1,
        sound:asset_get("sfx_blow_heavy2"),
        pitch:1.2,
        pitch_variation:0.1
    },
    {
        hitbox:2,
        sound:asset_get("sfx_blow_heavy2"),
        pitch:1.2,
        pitch_variation:0.1
    }]

    set_hitbox_value(AT_DAIR, 2, HG_PARENT_HITBOX, 1);
    set_hitbox_value(AT_DAIR, 2, HG_HITBOX_TYPE, 1);
    set_hitbox_value(AT_DAIR, 2, HG_WINDOW, 2);
    set_hitbox_value(AT_DAIR, 2, HG_LIFETIME, 3);
    set_hitbox_value(AT_DAIR, 2, HG_HITBOX_X, 10);
    set_hitbox_value(AT_DAIR, 2, HG_HITBOX_Y, -30);
    set_hitbox_value(AT_DAIR, 2, HG_WIDTH, 50);
    set_hitbox_value(AT_DAIR, 2, HG_HEIGHT, 60);
    set_hitbox_value(AT_DAIR, 2, HG_SHAPE, 0);
    set_hitbox_value(AT_DAIR, 2, HG_PRIORITY, 1);
    set_hitbox_value(AT_DAIR, 2, HG_DAMAGE, 12);
    set_hitbox_value(AT_DAIR, 2, HG_ANGLE, 250);
    set_hitbox_value(AT_DAIR, 2, HG_BASE_KNOCKBACK, 8);
    set_hitbox_value(AT_DAIR, 2, HG_KNOCKBACK_SCALING, 0.8);
    set_hitbox_value(AT_DAIR, 2, HG_BASE_HITPAUSE, 8);
    set_hitbox_value(AT_DAIR, 2, HG_HITPAUSE_SCALING, 1.0);
    set_hitbox_value(AT_DAIR, 2, HG_VISUAL_EFFECT, space_hit_vfx);
    set_hitbox_value(AT_DAIR, 2, HG_VISUAL_EFFECT_Y_OFFSET, 20);
} else {
    set_hitbox_value(AT_DAIR, 2, HG_PARENT_HITBOX, 2);
    set_hitbox_value(AT_DAIR, 2, HG_HITBOX_TYPE, 1);
    set_hitbox_value(AT_DAIR, 2, HG_WINDOW, 2);
    set_hitbox_value(AT_DAIR, 2, HG_LIFETIME, 3);
    set_hitbox_value(AT_DAIR, 2, HG_HITBOX_X, 10);
    set_hitbox_value(AT_DAIR, 2, HG_HITBOX_Y, -30);
    set_hitbox_value(AT_DAIR, 2, HG_WIDTH, 50);
    set_hitbox_value(AT_DAIR, 2, HG_HEIGHT, 60);
    set_hitbox_value(AT_DAIR, 2, HG_SHAPE, 0);
    set_hitbox_value(AT_DAIR, 2, HG_PRIORITY, 2);
    set_hitbox_value(AT_DAIR, 2, HG_DAMAGE, 6);
    set_hitbox_value(AT_DAIR, 2, HG_ANGLE, 45);
    set_hitbox_value(AT_DAIR, 2, HG_BASE_KNOCKBACK, 6);
    set_hitbox_value(AT_DAIR, 2, HG_KNOCKBACK_SCALING, 0.7);
    set_hitbox_value(AT_DAIR, 2, HG_BASE_HITPAUSE, 6);
    set_hitbox_value(AT_DAIR, 2, HG_HITPAUSE_SCALING, 1.0);
    set_hitbox_value(AT_DAIR, 2, HG_VISUAL_EFFECT, HFX_GEN_DIR);
    set_hitbox_value(AT_DAIR, 2, HG_VISUAL_EFFECT_Y_OFFSET, 20);
}