audio_stop_all(); 

room_goto(Menu);
global.ring = false;
global.mirror = false;
global.angel = false;
global.sword = false;
global.goblet = false;
ring = false;
mirror = false;
angel = false;
sword = false;
goblet = false;

with (obj_player) {
    instance_destroy();
}
