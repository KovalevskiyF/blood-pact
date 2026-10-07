// == Create Event (obj_mage) ==
/// направление и внешний вид
facing = choose(1, -1);
image_xscale = facing;
image_speed = 0.5;

// движение
xSpeed = 0;
ySpeed = 0;
vGravity = 0.4; // можно отрегулировать

// дистанции и скорости
see_distance = 300;
attack_distance = 220;   // расстояние, на котором маг хочет стрелять
safe_distance = 140;     // минимальная безопасная дистанция (если игрок ближе, маг отходит)
chase_speed = 1.1;
retreat_speed = 1.6;
proj_speed = 5.0;
proj_damage = 8;

// атака/таймеры
attack = false;
pre_attack = false;
attack_delay = 40;   // кадры подготовки (сколько ждать перед выстрелом)
attack_speed = 90;   // кадры между выстрелами (cooldown)
turn_cooldown = 0;
reacquire_pending = false;
reacquire_time = room_speed; // 1 сек

// поведение стояния / патруля (если нужно)
feel = 0;
stand_chance = 0.45;
stand_timer = irandom_range(60, 180);

// HP
hp = 20;

// состояния (для явной логики)
STATE_PATROL = 0;
STATE_CHASE = 1;
STATE_RETREAT = 2;
STATE_PREATTACK = 3;
STATE_COOLDOWN = 4;

state = STATE_PATROL;

// === AI таймеры ===
retreat_timer = 0;          // время, пока он отходит
retreat_pause = irandom_range(60, 120); // пауза перед новым отходом
can_retreat = true;          // может ли сейчас отходить

