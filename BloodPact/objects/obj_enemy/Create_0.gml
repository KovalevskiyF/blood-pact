// направление
xDir = choose(1, -1);
image_xscale = xDir;
image_speed = 0.6
// движение
xSpeed = 0;
ySpeed = 0;

// базовые параметры
vGravity = 0.3;
calm_speed = 0.5;
chase_speed = 1;
see_distance = 100;
hear_distance = 50;
attack_distance = 20;
attack_speed = 30;
attack_delay = 15;
damage = 10;
hp = 15;
// состояния
calm = true;
attack = false;
pre_attack = false;

// поведение стояния
feel = 0;
stand_chance = 0.4;
stand_timer = irandom_range(60, 180);

// повороты/таймеры
turn_cooldown = 0;

// reacquire
reacquire_pending = false;
reacquire_time = room_speed;
