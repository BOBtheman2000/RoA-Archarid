// I'm a web point! I lock players in place

sprite_idle = sprite_get("web_point_idle")
sprite_blink = sprite_get("web_point_blink")
sprite_hurt = sprite_get("web_point_hurt")

sprite_index = asset_get("empty_sprite")
mask_index = sprite_get("web_point_hurtbox")
real_sprite_index = sprite_idle
back_sprite = sprite_get("web_point_back")
web_line_sprite = sprite_get("web_line")
offscreen_sprite = sprite_get("web_point_offscreen")
flash_sprite = sprite_get("web_point_flash")

blink_timer = 60 + random_func(19, 120, true)
doing_blink = false
blink_animation_time = 30

doing_hurt_animation = false
hurt_animation_timer = 0
hurt_animation_time = 30

real_image_index = 0

lifetime = 0

// used for up special, stops the physics from happening while we're doing up b
// ALWAYS SET TO FALSE IF WE'RE NOT DOING ANYTHING ELSE!!!
override_all = false

snap_sound = asset_get("sfx_may_whip1")
death_vfx = hit_fx_create(sprite_get("web_point_death"), 12)

// drawing relevant stuff
    draw_x = 0
    draw_y = 0
    tether_list = []

is_hittable = true
ignores_walls = false

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

    tether_airtime = 0
    tether_airtime_warning = 270
    tether_airtime_max = 360

    tension_thresh = 0

    prime_dspecial_cooldown = false

// orb tether relevant stuff
    tethered_orb_queue = [] // just a list of orbs to queue up
    tethered_orbs = []
    // orb tethers are tracked in objects like this:
    /* {
        target: (some orb),
        parent: (bool), (if true, this orb is in charge of all the logic, otherwise, the target orb is in control)

        jumping_hitstun: (bool)

        jumping_lockout: (int)

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

    // affects jump staling
    jump_count_max = 10
    jump_falloff_mod = 0.3

snap_delay_time = 6 // if a tethered orb snaps, how long should it be before this one does

queue_snap = false
awaiting_snap = 0
awaiting_snap_x = 0
awaiting_snap_y = 0

// flo compat
// not really necessary and a bit forceful but it's funny, so long as it works we should be good
floStageCone = true
otherCone = noone
url = "3048939652"
yOffset = 0