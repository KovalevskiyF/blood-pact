if ring
{
	if spellCooldown < 0
{
	with instance_create_layer(x,y,"Instances",obj_player_ball)
	{
	
		speed = 3.7;
		direction = point_direction(x,y,mouse_x,mouse_y)
	}

	spellCooldown = 0.48
	hp -= 2;
}
}


