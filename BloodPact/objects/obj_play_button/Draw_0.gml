draw_self(); // если есть спрайт, можно убрать
draw_set_color(c_black);
draw_set_alpha(fade_alpha);
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_alpha(1);
draw_set_color(c_white);
