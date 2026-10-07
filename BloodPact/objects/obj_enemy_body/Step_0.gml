if(room==Room3) {
	depth = 0;
}
onGround = place_meeting(x, y + ySpeed,obj_block)
	if not onGround
	{
		ySpeed += vGravity 
	}
	else
	{
		ySpeed = 0;	
	}
y += ySpeed;

//Покраснение во второй
if (room == Room2) {
    if (instance_exists(obj_enemy_body)) {
        // Нормализуем X — чем дальше вправо, тем сильнее краснеет
        var ratio = clamp(obj_player.x / room_width, 0, 1);
        image_blend = merge_color(c_white, c_red, ratio);
    }
}
else {
    // В других комнатах — обычный цвет
    image_blend = c_white;
}

