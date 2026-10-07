	
if ((onGround||onLadder)&&!attack)
{
    moveSpeed = 0;
    attack = true;
    alarm_set(1, attack_speed);
	
	var sword_snd = true
	
    audio_play_sound(snd_sword_hit, 10, false);
	
	var attack_start_x = x + -facingDir * attack_distance/10;
    var attack_end_x = x + facingDir * attack_distance;
    var attack_y = y;
	instance_create_layer(attack_end_x - facingDir * 10, attack_y - 2, "Instances", obj_attack);

    var list = ds_list_create();
    collision_line_list(attack_start_x, attack_y, attack_end_x, attack_y, obj_enemy, false, true, list, true);
	collision_line_list(attack_start_x, attack_y, attack_end_x, attack_y, obj_enemy_1, false, true, list, true);
	collision_line_list(attack_start_x, attack_y, attack_end_x, attack_y, obj_bat, false, true, list, true);
    for (var i = 0; i < ds_list_size(list); i++)
    {
        var hit = list[| i];
        with (hit)
        {
            // если у врага есть переменная hp — отнимаем
            if (variable_instance_exists(id, "hp"))
            {
                hp -= other.attack_damage;

                // можно добавить проверку на смерть
                if (hp <= 0)
                {
                    instance_destroy();
                }
            }
        }
    }

    ds_list_destroy(list);
}

//Энэми1









/*instance_create_layer(attack_x-xDir*10, attack_y-4, "Instances", obj_attack); 
    var hit = instance_place(attack_x, attack_y, obj_enemy);
	var hit2 = instance_place(attack_x2, attack_y, obj_enemy);
    if (hit != noone||hit2 != noone)
    {
        with (hit)
        {
            instance_destroy();
        }
		with (hit2)
        {
            instance_destroy();
		}
    }
}
