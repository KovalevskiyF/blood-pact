// Если мы находимся в Menu или Room1
if (room == Menu || room == Room1) {
    // Если музыка не играет — запускаем
    if (!audio_is_playing(global.music_id)) {
        global.music_id = audio_play_sound(snd_menu_castle, 1, true);
        audio_sound_gain(global.music_id, 1, 0); // громкость 1 сразу
    }
} 
else {
    // Если вышли из Menu или Room1 — плавно затухаем
    if (audio_is_playing(global.music_id)) {
        var current_gain = audio_sound_get_gain(global.music_id);
        current_gain = max(0, current_gain - global.fade_speed);
        audio_sound_gain(global.music_id, current_gain, 0.1);

        if (current_gain <= 0.01) {
            audio_stop_sound(global.music_id);
            global.music_id = noone;
        }
    }
}