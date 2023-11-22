hurtbox_spr = asset_get("ex_guy_hurt_box");
crouchbox_spr = asset_get("ex_guy_crouch_box");
air_hurtbox_spr = -1;
hitstun_hurtbox_spr = -1;
small_sprites = true;

char_height = 52;
idle_anim_speed = .1;
crouch_anim_speed = .8;
crouch_active_anim_speed = .2;
walk_anim_speed = .125;
dash_anim_speed = .2;
pratfall_anim_speed = .25;

walk_speed = 2.25;
walk_accel = 0.8;
walk_turn_time = 6;
initial_dash_time = 4;
initial_dash_speed = 9;
dash_speed = 8.5;
dash_turn_time = 10;
dash_turn_accel = 1.5;
dash_stop_time = 4;
dash_stop_percent = .65; //the value to multiply your hsp by when going into idle from dash or dashstop
ground_friction = .6;
moonwalk_accel = 1.4;

jump_start_time = 5;
jump_speed = 13;
short_hop_speed = 10;
djump_speed = 12;
leave_ground_max = 5; //the maximum hsp you can have when you go from grounded to aerial without jumping
max_jump_hsp = 5; //the maximum hsp you can have when jumping from the ground
air_max_speed = 4; //the maximum hsp you can accelerate to when in a normal aerial state
jump_change = 3; //maximum hsp when double jumping. If already going faster, it will not slow you down
air_accel = .3;
prat_fall_accel = .9; //multiplier of air_accel while in pratfall
air_friction = .02;
max_djumps = 1;
double_jump_time = 32; //the number of frames to play the djump animation. Can't be less than 31.
walljump_hsp = 7;
walljump_vsp = 11;
walljump_time = 32;
max_fall = 16; //maximum fall speed without fastfalling
fast_fall = 22; //fast fall speed
gravity_speed = .75;
hitstun_grav = .5;
knockback_adj = 1.0; //the multiplier to KB dealt to you. 1 = default, >1 = lighter, <1 = heavier

land_time = 4; //normal landing frames
prat_land_time = 3;
wave_land_time = 8;
wave_land_adj = 1.35; //the multiplier to your initial hsp when wavelanding. Usually greater than 1
wave_friction = .04; //grounded deceleration when wavelanding

//crouch animation frames
crouch_startup_frames = 1;
crouch_active_frames = 1;
crouch_recovery_frames = 1;

//parry animation frames
dodge_startup_frames = 2;
dodge_active_frames = 1;
dodge_recovery_frames = 2;

//tech animation frames
tech_active_frames = 3;
tech_recovery_frames = 1;

//tech roll animation frames
techroll_startup_frames = 2
techroll_active_frames = 2;
techroll_recovery_frames = 2;
techroll_speed = 10;

//airdodge animation frames
air_dodge_startup_frames = 2;
air_dodge_active_frames = 1;
air_dodge_recovery_frames = 4;
air_dodge_speed = 7.5;

//roll animation frames
roll_forward_startup_frames = 1;
roll_forward_active_frames = 5;
roll_forward_recovery_frames = 3;
roll_back_startup_frames = 2;
roll_back_active_frames = 4;
roll_back_recovery_frames = 2;
roll_forward_max = 9; //roll speed
roll_backward_max = 9;

land_sound = asset_get("sfx_land_med");
landing_lag_sound = asset_get("sfx_land");
waveland_sound = asset_get("sfx_waveland_zet");
jump_sound = asset_get("sfx_jumpground");
djump_sound = asset_get("sfx_jumpair");
air_dodge_sound = asset_get("sfx_quick_dodge");

//visual offsets for when you're in Ranno's bubble
bubble_x = -4;
bubble_y = -2;

// ehehehe
can_wall_cling = true;

wall_climbing = 0;

wall_cling_sprite = sprite_get("walljump");
wall_climb_sprite_up = sprite_get("wallclimb_up");
wall_climb_sprite_down = sprite_get("wallclimb_down");

wall_climb_speed_up = -2;
wall_climb_speed_down = 3;

walljump_start_anim_time = 8;
walljump_leave_time = 0;
walljump_extended_time_default = 600;
walljump_extended_time = walljump_extended_time_default;

// it's like this so it remains consistent with other players
barney_archarid_tethered_to_orb = false
barney_archarid_current_orb = 0


// custom sound engine!
attack_sound_grid = array_create(50, [])
hit_sound_grid = array_create(50, [])

// usage example:

// attack_sound_grid[AT_BAIR] = [{
//     window:2,
//     frame:3,
//     sound:asset_get("mfx_star"),
//     pitch:1.2
//     pitch_variation:0.2
// }]

// hit sound example:

// hit_sound_grid[AT_BAIR] = [{
//     hitbox:2,
//     sound:asset_get("mfx_star"),
//     pitch:1.2
//     pitch_variation:0.2
// }]