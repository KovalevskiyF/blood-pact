// == Step Event (obj_mage) ==
if (room == Room3) {
    depth = 0;
}

// === Периодическое отступление ===
if (retreat_timer > 0) {
    retreat_timer -= 1;
    if (retreat_timer <= 0) {
        can_retreat = false;
        retreat_pause = irandom_range(90, 150); // пауза перед следующим отходом
    }
} else {
    retreat_pause -= 1;
    if (retreat_pause <= 0) {
        can_retreat = true;
        retreat_timer = irandom_range(45, 90); // отходит некоторое время
    }
}

// === Защита: если нет игрока ===
if (!instance_exists(obj_player)) {
    xSpeed = lerp(xSpeed, 0, 0.2);
    if (!place_meeting(x, y + 1, obj_block)) ySpeed += vGravity;
    else ySpeed = 0;
}

// === Таймеры ===
if (turn_cooldown > 0) turn_cooldown -= 1;
if (stand_timer > 0) stand_timer -= 1;

// === Сенсоры игрока ===
var saw_player = false;
if (instance_exists(obj_player)) {
    var view_y = y - sprite_height / 2;
    var found = collision_line(x, view_y, x + facing * see_distance, view_y, obj_player, false, true);
    var line_of_sight = !collision_line(x, y - 8, obj_player.x, obj_player.y - 8, obj_block, false, true);
    var dist = point_distance(x, y, obj_player.x, obj_player.y);

    if (found != noone || (dist <= see_distance && line_of_sight)) {
        saw_player = true;
        if (reacquire_pending) { alarm[1] = -1; reacquire_pending = false; }
    }
}

// === Решение состояния ===
if (saw_player) {
    var dist = point_distance(x, y, obj_player.x, obj_player.y);
    if (dist < safe_distance && can_retreat) {
        state = STATE_RETREAT;
    } else if (dist < safe_distance && !can_retreat) {
        state = STATE_PATROL;
        xSpeed = 0;
    } else if (dist > attack_distance * 1.2) {
        state = STATE_CHASE;
    } else {
        if (!attack && !pre_attack) {
            pre_attack = true;
            state = STATE_PREATTACK;
            xSpeed = 0;
            if (sprite_exists(spr_mage_cast)) { sprite_index = spr_mage_cast; image_index = 0; image_speed = 0.6; }
            alarm_set(3, attack_delay);
        } else {
            state = STATE_PATROL;
            xSpeed = 0;
        }
    }
} else {
    if (stand_timer <= 0) {
        feel = (random(1) < stand_chance) ? 2 : 0;
        stand_timer = irandom_range(60, 180);
    }
    state = STATE_PATROL;
}

// === Поведение по состоянию ===
var desired_speed = 0;
if (state == STATE_CHASE) {
    var dir = sign(obj_player.x - x);
    if (dir == 0) dir = 1;
    facing = dir;
    desired_speed = dir * chase_speed;
} else if (state == STATE_RETREAT) {
    var dir = sign(obj_player.x - x);
    if (dir == 0) dir = 1;
    facing = -dir;
    desired_speed = -dir * retreat_speed;
} else if (state == STATE_PATROL) {
    if (feel == 0) desired_speed = facing * 0.5;
    else desired_speed = 0;

    var look_ahead = 18;
    var check_x = x + facing * look_ahead;
    var check_y_ground = y + 17;
    if (turn_cooldown <= 0) {
        if (place_meeting(check_x, y, obj_block) || !place_meeting(check_x, check_y_ground, obj_block)) {
            facing = -facing;
            turn_cooldown = 12;
        }
    }
}

// === Плавное движение ===
xSpeed = lerp(xSpeed, desired_speed, 0.25);

// === Гравитация ===
if (!place_meeting(x, y + 1, obj_block)) ySpeed += vGravity;
else if (ySpeed > 0) ySpeed = 0;

// === Перемещение по X ===
var dx = xSpeed;
var steps = ceil(abs(dx));
var signx = (dx == 0) ? 0 : sign(dx);
for (var i = 0; i < steps; i++) {
    if (signx != 0) {
        if (!place_meeting(x + signx, y, obj_block)) {
            x += signx;
        } else {
            xSpeed = 0;
            if (place_meeting(x + signx, y + 1, obj_block) && !place_meeting(x + signx, y - 12, obj_block) && !place_meeting(x, y - 12, obj_block)) {
                ySpeed = -4;
            } else if (turn_cooldown <= 0) {
                facing *= -1;
                turn_cooldown = 12;
            }
            break;
        }
    }
}

// === Перемещение по Y ===
var dy = ySpeed;
var vsteps = ceil(abs(dy));
var signy = (dy == 0) ? 0 : sign(dy);
for (var j = 0; j < vsteps; j++) {
    if (signy != 0) {
        if (!place_meeting(x, y + signy, obj_block)) y += signy;
        else { ySpeed = 0; break; }
    }
}

// === Проверка границ комнаты (0–450 px) ===
if (x <= 0) {
    x = 0;
    facing = 1;
    can_retreat = false;
    retreat_pause = irandom_range(60, 120);
}
if (x >= 450) {
    x = 450;
    facing = -1;
    can_retreat = false;
    retreat_pause = irandom_range(60, 120);
}

// === Спрайты ===
if (!pre_attack) {
    if (place_meeting(x, y + 1, obj_block)) {
        if (abs(xSpeed) > 0.1) {
            if (sprite_exists(spr_mage)) { sprite_index = spr_mage; image_speed = 0.6; }
        } else {
            if (sprite_exists(spr_mage)) { sprite_index = spr_mage; image_speed = 0.2; }
        }
    } else {
        if (sprite_exists(spr_mage)) { sprite_index = spr_mage; image_speed = 0.1; }
    }
}

// === Поворот спрайта ===
if (instance_exists(obj_player)) {
    var lookDir = sign(obj_player.x - x);
    if (lookDir != 0) image_xscale = lookDir;
}

// === Безопасность у границ ===
if (place_meeting(x, y, obj_border)) {
    var overlap_x = 0;
    var overlap_y = 0;
    if (place_meeting(x + 1, y, obj_border)) overlap_x = -1;
    else if (place_meeting(x - 1, y, obj_border)) overlap_x = 1;
    if (place_meeting(x, y + 1, obj_border)) overlap_y = -1;
    else if (place_meeting(x, y - 1, obj_border)) overlap_y = 1;
    x += overlap_x;
    y += overlap_y;
}
