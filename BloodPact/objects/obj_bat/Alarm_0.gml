alarm_set(0,120)

if (instance_number(obj_player) > 0)
{
    targetX = obj_player.x + random_range(-400, 400);
    targetY = obj_player.y + random_range(-400, 400);

    // Ограничиваем по границам комнаты
    targetX = clamp(targetX, 0, room_width);
    targetY = clamp(targetY, 0, room_height);

    direction = point_direction(x, y, targetX, targetY);
}


