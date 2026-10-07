room_restart();
room_goto(Menu);
global.hp = 100;

xDir = 1;
facingDir = 1;

ySpeed = 0;
xSpeed = 0;

hp = global.hp;

vGravity = 0.3;
jumpSpeed = -6.5;
moveSpeed = 2;

fade_speed = 0.05;
walk_sound_id = noone;
run_sound_id = noone;

attack = false;
attack_speed = 20;
attack_distance = 20;
attack_damage = 10;

spellCooldown = 1;

ring = global.ring;

mirror = global.mirror;


angel = global.angel;


sword = global.sword;

goblet = global.goblet;
audio_stop_all(); 