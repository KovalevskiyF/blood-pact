if (fading && fade_alpha < 1) {
    fade_alpha = clamp(fade_alpha + fade_speed, 0, 1);
}
// Проверяем, наведен ли курсор на спрайт
if (position_meeting(mouse_x, mouse_y, id)) {
    image_index = 1; // подсвечиваем кнопку

    // Если нажата левая кнопка мыши
   if (mouse_check_button_pressed(mb_left)) {
    fading = true;          // начинаем затемнение
    alarm_set(0, 120);
}
} 
else {
    image_index = 0; // возвращаем обычный спрайт
}
