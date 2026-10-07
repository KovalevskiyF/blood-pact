/*var cam = view_camera[0];
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);
var w = camera_get_view_width(cam);
var h = camera_get_view_height(cam);

if (instance_exists(obj_player)) {
    var ratio = clamp(obj_player.x / room_width, 0, 1);
    var col = merge_color(c_white, c_red, ratio);
    draw_set_color(col);

    // Просто рисуем на позиции камеры — объект как будто "на экране"
    draw_sprite_stretched(sprite_index, image_index, cam_x, cam_y, w, h);

    draw_set_color(c_white);
}


if (instance_exists(obj_player)) {
    var ratio = clamp(obj_player.x / room_width, 0, 1);
    var col = merge_color(c_white, c_red, ratio);
    draw_set_color(col);

    draw_set_color(c_white);
}
