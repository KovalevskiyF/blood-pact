
alarm_set(0, 600); 


if (instance_exists(obj_player)) {

    var px = obj_player.x;
    var py = obj_player.y;


    if (instance_number(obj_bat) < 250) {

    
        repeat (10) {
            var dir = random(360);
            var dist = irandom_range(250, 400); 
            var xPos = px + lengthdir_x(dist, dir);
            var yPos = py + lengthdir_y(dist, dir);


            if (!place_meeting(xPos, yPos, obj_block)) {
                instance_create_layer(xPos, yPos, "Instances", obj_bat);
                break; 
            }
        }
    }
}
