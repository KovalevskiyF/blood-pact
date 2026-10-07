
if (place_meeting(x, y, obj_block)) {

    instance_destroy();
    exit;
}


var h = instance_place(x, y, obj_player);
if (h != noone) {
   
    h.hp -= damage;

    instance_destroy();
    exit;
}
