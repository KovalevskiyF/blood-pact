// Alarm[1] — повторная проверка после потери игрока (сработает через reacquire_time)
reacquire_pending = false;

// Если игрок существует — проверить ещё раз
if (instance_exists(obj_player)) {
    // обновим hear_distance (как в Step) — учёт скрытности не делаем здесь,
    // предполагаем, что hear_distance актуален из Step
    var view_y = y - sprite_height / 2;
    var found = collision_line(x, view_y, x + xDir * see_distance, view_y, obj_player, false, true);
    if (found != noone) hear_distance = see_distance;

    var player_close_enough = (distance_to_object(obj_player) <= hear_distance);
    var line_of_sight = !collision_line(x, y - 8, obj_player.x, obj_player.y - 8, obj_block, false, true);

    if (player_close_enough && line_of_sight) {
        // Всё ещё видит/слышит — продолжаем погоню
        calm = false;
        // не трогаем xSpeed — в Step дальше будет сглаживание и движение
    } else {
        // Не видит — сбрасываем в спокойный режим
        calm = true;
        // Вернуть поведение патруля (мягко), остановить погоню:
        xSpeed = xDir * calm_speed;
        // Можно также сбросить turn_cooldown, если нужно:
        // turn_cooldown = 0;
    }
} else {
    // Игрок исчез (удален) — возвращаемся в спокойный режим
    calm = true;
    xSpeed = xDir * calm_speed;
}
