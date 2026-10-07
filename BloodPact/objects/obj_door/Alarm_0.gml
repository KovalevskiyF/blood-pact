if (room == Room1)
	{
	obj_player.x = 25;
	obj_player.y = 179;
	room_goto(Room2);
	}
else
	{	
		obj_player.x = 16;
		obj_player.y = 658;
		room_goto(Room3);
	}
