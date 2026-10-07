persistent = true;

xDir = 1;
facingDir = 1;

ySpeed = 0;
xSpeed = 0;

//хп сохраняется при переходе, в степе глобальная переменная
if (!variable_global_exists("hp")) {
    global.hp = 100; // первый запуск
}
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
attack_damage = 10


spellCooldown = 1;

//АРТЕФАКТЫ

if (!variable_global_exists("ring")) {
	 global.ring = false;
}
ring = global.ring;


if (!variable_global_exists("mirror")) {
	 global.mirror = false;
}
mirror = global.mirror;


if (!variable_global_exists("angel")) {
	 global.angel = false;
}
angel = global.angel;


if (!variable_global_exists("sword")) {
	 global.sword = false;
}
sword = global.sword;

if (!variable_global_exists("goblet")) {
	 global.goblet = false;
}
goblet = global.goblet;