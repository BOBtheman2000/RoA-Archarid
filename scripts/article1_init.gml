// I'm a web point! I lock players in place

sprite_index = sprite_get("web_point")
web_line_sprite = sprite_get("web_line")

snap_sound = asset_get("sfx_may_whip1")

is_hittable = true

tether_type = 'player'
can_be_hit[other.player] = 30

// player tether relevant stuff
tethered_player = other

tether_distance_max = 120
tether_distance_snap = 20 // adds onto the original distance, used to handle teleports and the like
tether_hsp_snap = 15 // just a raw speed check, used for knockback
tether_vsp_snap = 20
tether_spring_mult_x = 0.8
tether_spring_mult_y = 1.0
tether_clamp_strength = 0.6

tension = 0

queue_snap = false
