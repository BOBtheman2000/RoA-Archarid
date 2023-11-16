// Custom crouch animation
if state == PS_CROUCH {
    if down_down {
        if state_timer <= 1/crouch_anim_speed {
            image_index = 0
        }
        else {
            image_index = floor((state_timer / (1/crouch_active_anim_speed)) % 4) + 1
        }
    }
    else {
        image_index = 5
    }
}