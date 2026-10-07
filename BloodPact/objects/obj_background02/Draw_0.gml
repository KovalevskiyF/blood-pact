
var cam = view_camera[0];
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);
var cam_w = camera_get_view_width(cam);
var cam_h = camera_get_view_height(cam);


if (instance_exists(obj_player) && room == Room2) {

    var ratio = clamp(obj_player.x / room_width, 0, 1);
    image_blend = merge_color(c_white, c_red, ratio);
} else {
    image_blend = c_white;
}


var scale_x = cam_w / sprite_width;
var scale_y = cam_h / sprite_height;

draw_sprite_ext(sprite_index, image_index, cam_x, cam_y, scale_x, scale_y, 0, image_blend, 1);
