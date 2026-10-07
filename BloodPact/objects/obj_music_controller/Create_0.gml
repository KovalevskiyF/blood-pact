global.music_id = noone;
global.fade_speed = 0.02; 
if (!audio_is_playing(global.music_id)) {
    global.music_id = audio_play_sound(snd_menu_castle, 1, true);
}

persistent = true; // чтобы не удалялся при переходе между комнатами