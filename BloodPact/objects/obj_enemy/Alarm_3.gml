if (instance_exists(obj_player)) {
    // Запускаем анимацию атаки
    sprite_index = spr_enemy_attack;
    image_index = 0;
    image_speed = 0.7;
    audio_play_sound(snd_sword_hit_1, 10, false);

    //урон позже
    alarm[4] = 18;
}

// Завершаем атаку
attack = true;
pre_attack = false;
alarm_set(2, attack_speed);

