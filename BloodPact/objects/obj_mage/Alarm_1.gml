// Alarm[1]
reacquire_pending = false;

if (instance_exists(obj_player)) {
    var line_of_sight = !collision_line(x, y - 8, obj_player.x, obj_player.y - 8, obj_block, false, true);
    var player_close = (point_distance(x, y, obj_player.x, obj_player.y) <= see_distance);

    if (player_close && line_of_sight) {
        // всё ещё видит
        // ничего не делаем — Step продолжит погоню
    } else {
        // не видит — возвращаемся в патруль
        state = STATE_PATROL;
        pre_attack = false;
        attack = false;
    }
}
