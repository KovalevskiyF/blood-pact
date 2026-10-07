if (instance_exists(obj_player)) 
{
    var _current_health = obj_player.hp;

    if (_current_health > 90) image_index = 0;
    else if (_current_health > 80) image_index = 1;
    else if (_current_health > 70) image_index = 2;
    else if (_current_health > 60) image_index = 3;
    else if (_current_health > 50) image_index = 4;
    else if (_current_health > 40) image_index = 5;
    else if (_current_health > 30) image_index = 6;
    else if (_current_health > 20) image_index = 7;
    else if (_current_health > 10) image_index = 8;
    else if (_current_health > 0) image_index = 9;
    else image_alpha = 0;
}

