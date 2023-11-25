// I'm a web point! I lock players in place

sprite_index = asset_get("empty_sprite")//sprite_get("web_point_idle")
mask_index = sprite_get("web_point_idle")
real_sprite_index = sprite_get("web_point_idle")
back_sprite = sprite_get("web_point_back")
web_line_sprite = sprite_get("web_line")

real_image_index = 0

lifetime = 0

snap_sound = asset_get("sfx_may_whip1")

// drawing relevant stuff
    draw_x = 0
    draw_y = 0
    tether_list = []

is_hittable = true
disable_movement = true

can_be_hit[other.player] = 10

// player tether relevant stuff
    tethered_player = noone

    tether_distance_max = 120
    tether_distance_max_archarid = 300
    tether_tension_snap = 20 // tension before the tether snaps
    tether_looseness = 0.8 // velocity multiplier when reducing the speed before applying tension modifier
    tether_bounce_modifier = 0.8 // strength of "bounciness"

    // alters the damage falloff formula for the tension threshold while in hitstun
    // 20/6/100/200 makes the damage falloff properly start at around 60, hits 12 at about 80
    // https://www.desmos.com/calculator/mpe1hfshm9 to check curve
    tether_tension_snap_hitstun = 20 // value at 0
    tether_tension_snap_hitstun_min = 6 // absolute minimum regardless of formula output
    tether_tension_snap_hitstun_damage_max = 100
    tether_tension_snap_hitstun_thresh_modifier = 200 // just trust me on this one

    // refuse to snap until inbounds
    tether_snap_lockout = false

    tension_thresh = 0

// orb tether relevant stuff
    tethered_orb_queue = [] // just a list of orbs to queue up
    tethered_orbs = []
    // orb tethers are tracked in objects like this:
    /* {
        target: (some orb),
        parent: (bool), (if true, this orb is in charge of all the logic, otherwise, the target orb is in control)

        jumping_state_timer: (int)
        jumping_state_time_max: (int)

        jumping_player: (some player)
        
        jumping_player_offset: (int)
        jumping_player_offset_max: (int)

        jumping_player_direction: (int)

        jump_strength: (int)

        jump_pull_sound: (some sound)

        jump_midpoint_x: (int)
        jump_midpoint_y: (int)
    } */

    jumping_state_time_max_mod = 13

    jump_strength_base = 10
    jump_strength_mod = 30

queue_snap = false
