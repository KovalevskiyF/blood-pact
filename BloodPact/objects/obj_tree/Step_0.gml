if (instance_exists(obj_player))
{
	if (obj_player.xSpeed !=0)
	{
		x += 0.6*obj_player.facingDir;
	}
}

if (instance_exists(obj_player))
{
    // Нормализуем x: чем дальше вправо, тем больше "красноты"
    var ratio = clamp(obj_player.x / room_width, 0, 1);

    // Меняем цвет от белого к красному
    image_blend = merge_color(c_white, c_red, ratio);
}
if (room != Room2){
	image_blend = merge_color(c_white, c_red, 0);
}
