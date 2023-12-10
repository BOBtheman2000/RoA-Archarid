set_attack_value(AT_DATTACK, AG_SPRITE, sprite_get("dattack"));
set_attack_value(AT_DATTACK, AG_NUM_WINDOWS, 3);
set_attack_value(AT_DATTACK, AG_AIR_SPRITE, sprite_get("dattack"));
set_attack_value(AT_DATTACK, AG_HURTBOX_SPRITE, sprite_get("dattack_hurt"));
set_attack_value(AT_DATTACK, AG_OFF_LEDGE, true);

attack_sound_grid[AT_DATTACK] = [{
    window:1,
    frame:4,
    sound:asset_get("sfx_swipe_medium1"),
    pitch:1.2,
    pitch_variation:0.2
},
{
    window:3,
    frame:1,
    sound:asset_get("sfx_land_heavy"),
    pitch:1.2,
    pitch_variation:0.2,
    volume:2
}]

set_window_value(AT_DATTACK, 1, AG_WINDOW_TYPE, 1);
set_window_value(AT_DATTACK, 1, AG_WINDOW_LENGTH, 4);
set_window_value(AT_DATTACK, 1, AG_WINDOW_ANIM_FRAMES, 1);
set_window_value(AT_DATTACK, 1, AG_WINDOW_ANIM_FRAME_START, 1);
set_window_value(AT_DATTACK, 1, AG_WINDOW_HSPEED, 2);

set_window_value(AT_DATTACK, 2, AG_WINDOW_TYPE, 1);
set_window_value(AT_DATTACK, 2, AG_WINDOW_LENGTH, 10);
set_window_value(AT_DATTACK, 2, AG_WINDOW_ANIM_FRAMES, 3);
set_window_value(AT_DATTACK, 2, AG_WINDOW_ANIM_FRAME_START, 2);
set_window_value(AT_DATTACK, 2, AG_WINDOW_HSPEED, 3);
set_window_value(AT_DATTACK, 2, AG_WINDOW_HSPEED_TYPE, 1);

set_window_value(AT_DATTACK, 3, AG_WINDOW_TYPE, 1);
set_window_value(AT_DATTACK, 3, AG_WINDOW_LENGTH, 22);
set_window_value(AT_DATTACK, 3, AG_WINDOW_ANIM_FRAMES, 3);
set_window_value(AT_DATTACK, 3, AG_WINDOW_ANIM_FRAME_START, 5);
set_window_value(AT_DATTACK, 3, AG_WINDOW_HSPEED, 4);
set_window_value(AT_DATTACK, 3, AG_WINDOW_HAS_WHIFFLAG, 5);


set_num_hitboxes(AT_DATTACK, 1);

hit_sound_grid[AT_DATTACK] = [{
    hitbox:1,
    sound:asset_get("sfx_blow_heavy2"),
    pitch:1.2,
    pitch_variation:0.1
}]

set_hitbox_value(AT_DATTACK, 1, HG_PARENT_HITBOX, 1);
set_hitbox_value(AT_DATTACK, 1, HG_HITBOX_TYPE, 1);
set_hitbox_value(AT_DATTACK, 1, HG_WINDOW, 2);
set_hitbox_value(AT_DATTACK, 1, HG_LIFETIME, 4);
set_hitbox_value(AT_DATTACK, 1, HG_HITBOX_X, 16);
set_hitbox_value(AT_DATTACK, 1, HG_HITBOX_Y, -28);
set_hitbox_value(AT_DATTACK, 1, HG_WIDTH, 58);
set_hitbox_value(AT_DATTACK, 1, HG_HEIGHT, 70);
set_hitbox_value(AT_DATTACK, 1, HG_PRIORITY, 2);
set_hitbox_value(AT_DATTACK, 1, HG_DAMAGE, 6);
set_hitbox_value(AT_DATTACK, 1, HG_ANGLE, 361);
set_hitbox_value(AT_DATTACK, 1, HG_BASE_KNOCKBACK, 8);
set_hitbox_value(AT_DATTACK, 1, HG_KNOCKBACK_SCALING, .8);
set_hitbox_value(AT_DATTACK, 1, HG_BASE_HITPAUSE, 8);
set_hitbox_value(AT_DATTACK, 1, HG_HITPAUSE_SCALING, .9);
set_hitbox_value(AT_DATTACK, 1, HG_VISUAL_EFFECT, space_hit_vfx);
set_hitbox_value(AT_DATTACK, 1, HG_VISUAL_EFFECT_X_OFFSET, 8);
set_hitbox_value(AT_DATTACK, 1, HG_VISUAL_EFFECT_Y_OFFSET, 8);
set_hitbox_value(AT_DATTACK, 1, HG_HIT_LOCKOUT, 5);
