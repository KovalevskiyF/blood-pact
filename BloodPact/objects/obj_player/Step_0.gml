//сохранение хп, присваивание в глобальную переменную
global.hp = hp;
if(room==Room3) {
	depth = 0;
}
//артефакты
global.ring = ring;
global.mirror = mirror;
global.angel = angel;
global.sword = sword;
global.goblet = goblet;

if (global.ring && global.mirror && global.angel && global.sword && global.goblet) {
  alarm[0] = room_speed * 5;
}

if (hp>100){
hp = 100;
}

if (angel == true){
	hp+=0.1;
}

if global.sword 
{
	attack_speed = 10;
attack_distance = 30;
attack_damage = 25;
}
if not attack
{xDir = keyboard_check(ord("D")) - keyboard_check(ord("A"));
// D : 1 - 0 = 1 (вправо)
// A : 0 - 1 = -1 (влево)
// ничего : 0 - 0 = 0
// D + A : 1 - 1 = 0

if (xDir != 0)
{
    facingDir = xDir;
	
}
if !keyboard_check(vk_shift)
{
	moveSpeed =1.8;
	
}
else 
{
	if (room != Room2) {
	moveSpeed = 2.3;
	}
}
yDir = keyboard_check(ord("S")) - keyboard_check(ord("W"));

// Прыжок по W
pressedJump = keyboard_check_pressed(ord("W"));
}
onGround = place_meeting(x, y + 1,obj_block)

onLadder = place_meeting(x, y + 1 ,obj_ladder)



xSpeed = xDir * moveSpeed;

spellCooldown -= 1/60



if onLadder
{
	ySpeed = yDir * moveSpeed;
	
}
else
{
	if pressedJump and onGround
	{
		ySpeed = jumpSpeed;
	}
	ySpeed += vGravity 
}




if xDir != 0
	image_xscale = xDir

//АНИМИЦАЯ БЕГА ХОДБЮЫ
if xSpeed == 0 {
    image_speed = 0
} else {
    if keyboard_check(vk_shift) {
        image_speed = 1.5 // быстрее при беге
    } else {
        image_speed = 0.9 // обычная скорость при ходьбе
    }
}	
if onGround
{	
	sprite_index = spr_player_move
	if xSpeed == 0
	sprite_index = spr_player
}
else
	sprite_index = spr_player_jump



if place_meeting(x + xSpeed, y, obj_block)
{
	xSpeed = 0
}

if place_meeting(x + xSpeed+5*xDir, y, obj_border)
{
	xSpeed = 0
}
else 


if place_meeting(x, y + ySpeed, obj_block)
{
	ySpeed = 0
}


x += xSpeed
y += ySpeed
if hp<1
{instance_destroy()}


//чтобы не застревал
if (!onGround && vspeed == 0||place_meeting(x, y, obj_block))
{
    var offset = 0;
    while (place_meeting(x, y, obj_block) && offset < 5)
    {
        y -= 1;
        offset += 1;
    }

    if (offset == 0)
    {
        offset = 0;
        while (place_meeting(x, y, obj_block) && offset < 5)
        {
            y += 1;
            offset += 1;
        }
    }
}



// звук ходьбы
if (!keyboard_check(vk_shift))
{
	if (xDir != 0 && onGround && xSpeed != 0)
	{
		if (!audio_is_playing(walk_sound_id))
			walk_sound_id = audio_play_sound(snd_walk, 10, true);
	}
	else 
	{
		if (audio_is_playing(walk_sound_id))
			audio_stop_sound(walk_sound_id);
		
			
	
	}
}
else 
	{
		
		if (audio_is_playing(walk_sound_id))
			audio_stop_sound(walk_sound_id);
		
	}

//звук бега
if (room != Room2) 
{
	
	
if (xDir != 0 && onGround && xSpeed != 0)
	{
		if keyboard_check(vk_shift)
		{
			if (!audio_is_playing(run_sound_id))
				run_sound_id = audio_play_sound(snd_run, 10, true);
		}
		else 
		{
		if (audio_is_playing(run_sound_id))
			audio_stop_sound(run_sound_id);
		}	
	}
	else 
	{
		
		if (audio_is_playing(run_sound_id))
			audio_stop_sound(run_sound_id);
	
	}


}


//Покраснение во второй
// Покраснение во второй комнате
if (room == Room2) {
    if (instance_exists(obj_player)) {
        // Нормализуем X — чем дальше вправо, тем сильнее краснеет
        var ratio = clamp(obj_player.x / room_width, 0, 1);
        image_blend = merge_color(c_white, c_red, ratio);
    }
}
else {
    // В других комнатах — обычный цвет
    image_blend = c_white;
}

