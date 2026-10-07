if !al
{
	if (global.angel&&global.ring&&global.mirror&&global.sword&&global.goblet)
	{
	obj_player.xSpeed = 0;
        fading = true;
        alarm_set(0, 120);
		al = true;

	}
}

if (fading) 
{
	
	var layer_id = layer_get_id("UILayer_1");
	layer_set_visible(layer_id, false); 
    
	fade_alpha += fade_speed;
	if (fade_alpha > 1) fade_alpha = 1;
}