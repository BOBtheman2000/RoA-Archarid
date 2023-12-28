set_attack_value(AT_DSPECIAL, AG_CATEGORY, 2);
set_attack_value(AT_DSPECIAL, AG_SPRITE, sprite_get("dspecial"));
set_attack_value(AT_DSPECIAL, AG_NUM_WINDOWS, 4);
set_attack_value(AT_DSPECIAL, AG_HAS_LANDING_LAG, 4);
set_attack_value(AT_DSPECIAL, AG_OFF_LEDGE, 1);
set_attack_value(AT_DSPECIAL, AG_AIR_SPRITE, sprite_get("dspecial"));
set_attack_value(AT_DSPECIAL, AG_HURTBOX_SPRITE, sprite_get("dspecial_hurt"));

attack_sound_grid[AT_DSPECIAL] = [{
    window:1,
    frame:1,
    sound:asset_get("sfx_jumpair"),
    pitch:0.6,
    pitch_variation:0.2
},
{
    window:2,
    frame:1,
    sound:asset_get("sfx_swipe_heavy1"),
    pitch:1.6,
    pitch_variation:0.2
}]

// Initial startup (Allows for B reversals to flip momentum)
set_window_value(AT_DSPECIAL, 1, AG_WINDOW_TYPE, 1);
set_window_value(AT_DSPECIAL, 1, AG_WINDOW_LENGTH, 3);
set_window_value(AT_DSPECIAL, 1, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_DSPECIAL, 1, AG_WINDOW_ANIM_FRAME_START, 1);
set_window_value(AT_DSPECIAL, 1, AG_WINDOW_HSPEED, 10);
set_window_value(AT_DSPECIAL, 1, AG_WINDOW_HSPEED_TYPE, 2);
set_window_value(AT_DSPECIAL, 1, AG_WINDOW_VSPEED, -4);
set_window_value(AT_DSPECIAL, 1, AG_WINDOW_VSPEED_TYPE, 2);

// Airborne
set_window_value(AT_DSPECIAL, 2, AG_WINDOW_TYPE, 8);
set_window_value(AT_DSPECIAL, 2, AG_WINDOW_LENGTH, has_rune("I") ? 5 : 15);
set_window_value(AT_DSPECIAL, 2, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_DSPECIAL, 2, AG_WINDOW_ANIM_FRAME_START, 2);
set_window_value(AT_DSPECIAL, 2, AG_WINDOW_HSPEED, 10);
set_window_value(AT_DSPECIAL, 2, AG_WINDOW_HSPEED_TYPE, 2);
set_window_value(AT_DSPECIAL, 2, AG_WINDOW_VSPEED, -4);
set_window_value(AT_DSPECIAL, 2, AG_WINDOW_VSPEED_TYPE, 2);

// Active
set_window_value(AT_DSPECIAL, 3, AG_WINDOW_TYPE, 1);
set_window_value(AT_DSPECIAL, 3, AG_WINDOW_LENGTH, 3);
set_window_value(AT_DSPECIAL, 3, AG_WINDOW_ANIM_FRAMES, 2);
set_window_value(AT_DSPECIAL, 3, AG_WINDOW_ANIM_FRAME_START, 3);
set_window_value(AT_DSPECIAL, 3, AG_WINDOW_HSPEED, -3);
set_window_value(AT_DSPECIAL, 3, AG_WINDOW_HSPEED_TYPE, 2);
set_window_value(AT_DSPECIAL, 3, AG_WINDOW_VSPEED, -10);
set_window_value(AT_DSPECIAL, 3, AG_WINDOW_VSPEED_TYPE, 2);

// Endlag
set_window_value(AT_DSPECIAL, 4, AG_WINDOW_TYPE, 1);
set_window_value(AT_DSPECIAL, 4, AG_WINDOW_LENGTH, 8);
set_window_value(AT_DSPECIAL, 4, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_DSPECIAL, 4, AG_WINDOW_ANIM_FRAME_START, 5);

set_num_hitboxes(AT_DSPECIAL, 2);

hit_sound_grid[AT_DSPECIAL] = [{
    hitbox:1,
    sound:asset_get("sfx_may_whip1"),
    pitch:1.8,
    pitch_variation:0.1
}]

// normal hitbox for players
set_hitbox_value(AT_DSPECIAL, 1, HG_PARENT_HITBOX, 1);
set_hitbox_value(AT_DSPECIAL, 1, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_DSPECIAL, 1, HG_WINDOW, 3);
set_hitbox_value(AT_DSPECIAL, 1, HG_LIFETIME, 3);
set_hitbox_value(AT_DSPECIAL, 1, HG_HITBOX_X, 30);
set_hitbox_value(AT_DSPECIAL, 1, HG_HITBOX_Y, -20);
set_hitbox_value(AT_DSPECIAL, 1, HG_WIDTH, 70);
set_hitbox_value(AT_DSPECIAL, 1, HG_HEIGHT, 50);
set_hitbox_value(AT_DSPECIAL, 1, HG_PRIORITY, 1);
set_hitbox_value(AT_DSPECIAL, 1, HG_DAMAGE, 4);
set_hitbox_value(AT_DSPECIAL, 1, HG_BASE_KNOCKBACK, 8);
set_hitbox_value(AT_DSPECIAL, 1, HG_KNOCKBACK_SCALING, .0);
set_hitbox_value(AT_DSPECIAL, 1, HG_ANGLE, 361);
set_hitbox_value(AT_DSPECIAL, 1, HG_BASE_HITPAUSE, 3);
set_hitbox_value(AT_DSPECIAL, 1, HG_VISUAL_EFFECT, web_hit_vfx_small);
set_hitbox_value(AT_DSPECIAL, 1, HG_ANGLE_FLIPPER, 6);
set_hitbox_value(AT_DSPECIAL, 1, HG_TECHABLE, 1);

// detection hitbox for web points
set_hitbox_value(AT_DSPECIAL, 2, HG_PARENT_HITBOX, 2);
set_hitbox_value(AT_DSPECIAL, 2, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_DSPECIAL, 2, HG_WINDOW, 3);
set_hitbox_value(AT_DSPECIAL, 2, HG_LIFETIME, 3);
set_hitbox_value(AT_DSPECIAL, 2, HG_HITBOX_X, 30);
set_hitbox_value(AT_DSPECIAL, 2, HG_HITBOX_Y, -20);
set_hitbox_value(AT_DSPECIAL, 2, HG_WIDTH, 110);
set_hitbox_value(AT_DSPECIAL, 2, HG_HEIGHT, 110);
set_hitbox_value(AT_DSPECIAL, 2, HG_PRIORITY, 0);
set_hitbox_value(AT_DSPECIAL, 2, HG_DAMAGE, 0);
set_hitbox_value(AT_DSPECIAL, 2, HG_BASE_KNOCKBACK, 0);
set_hitbox_value(AT_DSPECIAL, 2, HG_KNOCKBACK_SCALING, .0);
set_hitbox_value(AT_DSPECIAL, 2, HG_ANGLE, 361);
set_hitbox_value(AT_DSPECIAL, 2, HG_BASE_HITPAUSE, 0);
set_hitbox_value(AT_DSPECIAL, 2, HG_TECHABLE, 1);

// rune hitbox
set_hitbox_value(AT_DSPECIAL, 3, HG_PARENT_HITBOX, 3);
set_hitbox_value(AT_DSPECIAL, 3, HG_HITBOX_TYPE, 2);
set_hitbox_value(AT_DSPECIAL, 3, HG_WINDOW, 0);
set_hitbox_value(AT_DSPECIAL, 3, HG_LIFETIME, 4);
set_hitbox_value(AT_DSPECIAL, 3, HG_HITBOX_X, 0);
set_hitbox_value(AT_DSPECIAL, 3, HG_HITBOX_Y, 0);
set_hitbox_value(AT_DSPECIAL, 3, HG_WIDTH, 50);
set_hitbox_value(AT_DSPECIAL, 3, HG_HEIGHT, 50);
set_hitbox_value(AT_DSPECIAL, 3, HG_PRIORITY, 2);
set_hitbox_value(AT_DSPECIAL, 3, HG_DAMAGE, 5);
set_hitbox_value(AT_DSPECIAL, 3, HG_BASE_KNOCKBACK, 8);
set_hitbox_value(AT_DSPECIAL, 3, HG_KNOCKBACK_SCALING, .8);
set_hitbox_value(AT_DSPECIAL, 3, HG_BASE_HITPAUSE, 8);
set_hitbox_value(AT_DSPECIAL, 3, HG_VISUAL_EFFECT, HFX_ELL_BOOM_BIG);
set_hitbox_value(AT_DSPECIAL, 3, HG_ANGLE_FLIPPER, 8);

set_hitbox_value(AT_DSPECIAL, 3, HG_PROJECTILE_SPRITE, asset_get("empty_sprite"));
set_hitbox_value(AT_DSPECIAL, 3, HG_PROJECTILE_MASK, -1);
set_hitbox_value(AT_DSPECIAL, 3, HG_PROJECTILE_WALL_BEHAVIOR, 1);
set_hitbox_value(AT_DSPECIAL, 3, HG_PROJECTILE_GROUND_BEHAVIOR, 1);
set_hitbox_value(AT_DSPECIAL, 3, HG_PROJECTILE_ENEMY_BEHAVIOR, 1);