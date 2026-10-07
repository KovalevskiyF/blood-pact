if (room == Room1 || room == Room2 || room == Room3)
{
    // Получаем камеру и её позицию
    var cam = view_camera[0];
    var cam_x = camera_get_view_x(cam);
    var cam_y = camera_get_view_y(cam);

    // Отступ от угла камеры
    var offset_x = 280;
    var offset_y = 20;

    // Масштаб спрайта (1 = оригинальный размер)
    var scale_x = 0.3;
    var scale_y = 0.3;

    // Координаты для рисования относительно камеры
    var draw_x = cam_x + offset_x;
    var draw_y = cam_y + offset_y;

    // Рисуем спрайт с учётом масштаба
    draw_sprite_ext(sprite_index, image_index, draw_x, draw_y, scale_x, scale_y, 0, c_white, 1);
}
