sprite_change_offset("idle", 28, 39);
sprite_change_offset("hurt", 28, 29);
sprite_change_offset("crouch", 28, 39);
sprite_change_offset("walk", 28, 29);
sprite_change_offset("walkturn", 28, 29);
sprite_change_offset("dash", 28, 29);
sprite_change_offset("dashstart", 28, 29);
sprite_change_offset("dashstop", 28, 29);
sprite_change_offset("dashturn", 28, 39);

sprite_change_offset("jumpstart", 28, 39);
sprite_change_offset("jump", 28, 39);
sprite_change_offset("doublejump", 28, 39);
sprite_change_offset("walljump", 57, 89);
sprite_change_offset("wallclimb_up", 57, 89);
sprite_change_offset("wallclimb_down", 57, 89);
sprite_change_offset("pratfall", 58, 89);
sprite_change_offset("land", 58, 69);
sprite_change_offset("landinglag", 58, 69);

sprite_change_offset("hurt", 28, 39);
sprite_change_offset("bighurt", 28, 39);
sprite_change_offset("hurtground", 28, 39);
sprite_change_offset("spinhurt", 58, 89);
sprite_change_offset("downhurt", 58, 89);

sprite_change_offset("parry", 58, 89);
sprite_change_offset("roll_forward", 58, 89);
sprite_change_offset("roll_backward", 58, 89);
sprite_change_offset("airdodge", 28, 39);
sprite_change_offset("waveland", 58, 69);
sprite_change_offset("tech", 58, 69);

sprite_change_offset("jab", 22, 29, true);
sprite_change_offset("dattack", 58, 89, true);
sprite_change_offset("ftilt", 58, 89, true);
sprite_change_offset("dtilt", 58, 69, true);
sprite_change_offset("utilt", 58, 89, true);
sprite_change_offset("nair", 58, 69, true);
sprite_change_offset("fair", 58, 89);
sprite_change_offset("fair_hurt", 58*2, 69*2);
sprite_change_offset("bair", 58, 89, true);
sprite_change_offset("uair", 58, 89, true);
sprite_change_offset("dair", 58, 89, true);
sprite_change_offset("wair", 57, 89, true);
sprite_change_offset("fstrong", 58, 89, true);
sprite_change_offset("ustrong", 58, 89, true);
sprite_change_offset("dstrong", 58, 89, true);
sprite_change_offset("nspecial", 58, 89, true);
sprite_change_offset("nspecial_air", 58, 89);
sprite_change_offset("nspecial_hurt_air", 58*2, 89*2);
sprite_change_offset("fspecial", 58, 89, true);
sprite_change_offset("fspecial_air", 58, 89);
sprite_change_offset("fspecial_hurt_air", 58*2, 89*2);
sprite_change_offset("uspecial", 58, 89, true);
sprite_change_offset("dspecial", 58, 89, true);
sprite_change_offset("wspecial", 57, 89, true);
sprite_change_offset("taunt", 58, 89);

sprite_change_offset("plat", 32, 47);

sprite_change_offset("web_point_spawn", 14, 14);
sprite_change_offset("web_point_idle", 18, 18);
sprite_change_offset("web_point_blink", 18, 18);
sprite_change_offset("web_point_hurt", 18, 18);
sprite_change_offset("web_point_back", 36, 36);
sprite_change_offset("web_point_death", 36, 36);
sprite_change_offset("web_point_flash", 18, 18);

sprite_change_offset("web_point_hurtbox", 18, 18);
sprite_change_offset("web_point_offscreen", 15, 15);

sprite_change_offset("web_line_sprite", 0, 3);

sprite_change_offset("nspecial_proj", 19, 9);
sprite_change_offset("nspecial_proj_fast", 30, 9);

sprite_change_offset("hit_vfx_web", 220, 220);
sprite_change_offset("hit_vfx_web_small", 60, 60);
sprite_change_offset("hit_vfx_tiny", 32, 32);
sprite_change_offset("space_hit_vfx", 64, 64);

web_hit_vfx = hit_fx_create(sprite_get("hit_vfx_web"), 16)
web_hit_vfx_small = hit_fx_create(sprite_get("hit_vfx_web_small"), 16)
tiny_hit_vfx = hit_fx_create(sprite_get("hit_vfx_tiny"), 16)
space_hit_vfx = hit_fx_create(sprite_get("space_hit_vfx"), 24)