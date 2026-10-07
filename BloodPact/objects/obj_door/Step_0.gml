if global.ring {

if (place_meeting(x, y, obj_player)) {
    if (keyboard_check_pressed(ord("E"))) {
        obj_player.xSpeed = 0;
        fading = true;
        alarm_set(0, 120); // через 2 секунды (если 60 fps)
    }
}

// Плавное затемнение
if (fading) {
	
	var layer_id = layer_get_id("UILayer_1");
	layer_set_visible(layer_id, false); 
    
	fade_alpha += fade_speed;
    if (fade_alpha > 1) fade_alpha = 1;
}


}