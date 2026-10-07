gunCooldown -= 1/90

if gunCooldown < 0 and instance_number(obj_player)>0
{
	with instance_create_layer(x,y,"Instances",obj_enemy_bullet)
	{
		speed = 2.5;
		direction = point_direction(x,y,obj_player.x,obj_player.y)
	}
	
	gunCooldown = random_range(1,2)
	
}

//Покраснение во второй
if (room == Room2) {
    if (instance_exists(obj_bat)) {
        // Нормализуем X — чем дальше вправо, тем сильнее краснеет
        var ratio = clamp(obj_player.x / room_width, 0, 1);
        image_blend = merge_color(c_white, c_red, ratio);
    }
}
else {
    // В других комнатах — обычный цвет
    image_blend = c_white;
}
