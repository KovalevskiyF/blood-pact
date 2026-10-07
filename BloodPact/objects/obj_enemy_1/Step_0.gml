if(room==Room3) {
	depth = 0;
}
// ----- 1) Уменьшаем кулдаун переворота -----
if (turn_cooldown > 0) turn_cooldown -= 1;

// ----- 2) Проверка на земле -----
onGround = place_meeting(x, y + 1, obj_block);

// ----- 3) Вертикальная физика (гравитация) -----
if (!place_meeting(x, y + 1, obj_block)) {
    ySpeed += vGravity;
} else {
    if (ySpeed > 0) ySpeed = 0;
}

// ----- 4) Сенсоры и логика обнаружения игрока -----
if (instance_exists(obj_player)) {

    // 'глаз' (луч) чуть выше головы
    var view_y = y - sprite_height / 2;
    var found = collision_line(x, view_y, x + xDir * see_distance, view_y, obj_player, false, true);

    if (found != noone) {
        hear_distance = see_distance;
        calm = false;
        // если был запущен таймер пере-приобретения — отменим
        if (reacquire_pending) {
            alarm[1] = -1;
            reacquire_pending = false;
        }
    }

    // режим скрытности (shift)
    if (!keyboard_check_direct(vk_shift) && calm) {
        hear_distance = 10;
    } else if (calm) {
        hear_distance = 50;
    }

    // слышимость/видимость для повторной проверки
    var player_close = (distance_to_object(obj_player) <= hear_distance);
    var line_of_sight = !collision_line(x, y - 8, obj_player.x, obj_player.y - 8, obj_block, false, true);

    if (player_close && line_of_sight) {
        calm = false;
        // reacquire_pending уже отменялся выше, если нужно
    } else {
        // Если раньше преследовал и таймер еще не запущен — запустить повторную проверку
        if (!calm && !reacquire_pending) {
            alarm_set(1, reacquire_time);
            reacquire_pending = true;
        }
    }

    // ----- 5) Движение: погоня или патруль/стояние -----
    if (!calm) {
        // ПОГОНЯ (игнорируем логику края платформы)
        xDir = sign(obj_player.x - x);
        if (xDir == 0) xDir = 1;
        image_xscale = xDir;

        var dist = abs(obj_player.x - x);
        var target_speed = (dist > attack_distance ? xDir * chase_speed : 0);

        // плавное изменение скорости
        xSpeed = lerp(xSpeed, target_speed, 0.35);

    } else {
        // СПОКОЙНО / ПАТРУЛЬ / СТОЯНИЕ

        // обновляем таймер стояния/патруля
        if (stand_timer > 0) stand_timer -= 1;
        if (stand_timer <= 0) {
            feel = (random(1) < stand_chance) ? 2 : 0;
            stand_timer = irandom_range(60, 180);
        }

        // Развороты при стенах и на краях — выполняем всегда (чтобы стояние тоже могло поворачиваться)
        var look_ahead = 16 + 4; // запас
        var check_x = x + xDir * look_ahead;
        var check_y_ground = y + 17;

        if (place_meeting(check_x, y, obj_block) && turn_cooldown <= 0) {
            xDir = -xDir;
            turn_cooldown = 12;
        } else if (!place_meeting(check_x, check_y_ground, obj_block) && turn_cooldown <= 0) {
            xDir = -xDir;
            turn_cooldown = 12;
        }

        image_xscale = xDir;

        if (feel == 0) {
            // ПАТРУЛЬ — идём
            xSpeed = lerp(xSpeed, xDir * calm_speed, 0.18);
        } else {
            // СТОЯНИЕ — стоим, но direction всё ещё может меняться сверху
            xSpeed = lerp(xSpeed, 0, 0.18);
        }
    }
} // конец instance_exists(obj_player)

// ----- 6) Применяем горизонтальное движение и обрабатываем столкновения -----
x += xSpeed;

// Если столкновение с блоком по горизонтали
if (place_meeting(x, y, obj_block)) {
    // откат назад
    x -= xSpeed;
    xSpeed = 0;

    // если на земле и есть пространство над текущей позицией (низ блока не слишком высокий) — попытка "перешагнуть"
    if (onGround && !place_meeting(x, y - 12, obj_block)) {
        ySpeed = -4; // маленький прыжок через низкий блок
        onGround = false;
    } else if (onGround) {
        // не можем перепрыгнуть — просто развернуться
        xDir = -xDir;
        image_xscale = xDir;
        turn_cooldown = 12;
    }
}

// ----- 7) Вертикальное движение и проверка пола/потолка -----
y += ySpeed;

// проверка пола
if (place_meeting(x, y + 1, obj_block)) {
    onGround = true;
    ySpeed = 0;
    // подтянуть наверх, если пересекаем блок
    while (place_meeting(x, y, obj_block)) y -= 1;
} else {
    onGround = false;
}

// проверка потолка
if (ySpeed < 0 && place_meeting(x, y - 1, obj_block)) {
    while (place_meeting(x, y, obj_block)) y += 1;
    ySpeed = 0;
}

// дополнительная страховка от залипания внутри блока
if (place_meeting(x, y, obj_block)) {
    var safe_iter = 0;
    while (place_meeting(x, y, obj_block) && safe_iter < 50) {
        y -= 1;
        safe_iter += 1;
    }
    ySpeed = 0;
}

// ----- 8) АТАКА (подготовка с задержкой) -----
if (onGround && !attack && !pre_attack && instance_exists(obj_player)) {
    var attack_x = x + xDir * attack_distance;
    var hit = instance_place(attack_x, y, obj_player);

    if (hit != noone) {
        pre_attack = true;
        xSpeed = 0;
        // запустить Alarm[3], который совершит удар (у тебя уже настроен)
        alarm_set(3, attack_delay);
    }
}

//Покраснение во второй
if (room == Room2) {
    if (instance_exists(obj_enemy_1)) {
        // Нормализуем X — чем дальше вправо, тем сильнее краснеет
        var ratio = clamp(obj_player.x / room_width, 0, 1);
        image_blend = merge_color(c_white, c_red, ratio);
    }
}
else {
    // В других комнатах — обычный цвет
    image_blend = c_white;
}

