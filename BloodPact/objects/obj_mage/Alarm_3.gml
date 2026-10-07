// Alarm[3] — маг кастует снаряд
pre_attack = false;

if (!instance_exists(obj_player)) {
    // отмена выстрела — сброс в cooldown
    attack = true;
    alarm_set(2, attack_speed);
    exit;
}

// создаём снаряд чуть впереди мага
var dir_to_player = point_direction(x, y, obj_player.x, obj_player.y);
var bx = x + lengthdir_x(12, dir_to_player);
var by = y + lengthdir_y(8, dir_to_player);

var b = instance_create_layer(bx, by, "Instances", obj_enemy_ball);
if (b != noone) {
    b.direction = dir_to_player;
    b.speed = proj_speed;
    b.damage = proj_damage; // урон будет получать игрок через столкновение с снарядом
}

// звук кастинга (если есть)
//if (sound_exists(snd_magic_cast)) audio_play_sound(snd_magic_cast, 1, false);

// переход к перезарядке
attack = true;
alarm_set(2, attack_speed);

// вернуть спрайт назад на Idle
if (sprite_exists(spr_mage)) {
    sprite_index = spr_mage;
    image_speed = 0.5;
}
