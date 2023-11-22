// I'm a web point! I lock players in place

sprite_index = sprite_get("web_point")
web_line_sprite = sprite_get("web_line")

snap_sound = asset_get("sfx_may_whip1")

is_hittable = true

tether_type = 'player'
can_be_hit[other.player] = 10

// player tether relevant stuff
    tethered_player = other

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
    tethered_orb = false

queue_snap = false
