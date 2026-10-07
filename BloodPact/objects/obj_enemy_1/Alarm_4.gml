// Alarm[4] — наносим урон, когда идёт второй кадр анимации
if (instance_exists(obj_player)) {
    var attack_x = x + xDir * attack_distance;
    var hit3 = instance_place(attack_x, y, obj_player);

    if (hit3 != noone) {
        with (hit3) {
            hp -= other.damage; // Урон от врага
			obj_player.xDir = obj_enemy_1.xDir;
			obj_player.xSpeed += obj_enemy_1.xDir*100;
        }
    }
}
		sprite_index = spr_enemy_1;
		image_speed = 0;
		image_index = 0;