public class GameDemo : Object {
    public static int main (string[] args) {
        var engine = new Darkcore.Engine(640, 480);
        
        
        
        var player = new Darkcore.Sprite ();
        player.world = engine;
        //player.color_r = 100;
        player.x += 32;
        player.y += 100;
        player.height = 100;
        player.on_key_press = ((engine, player) => {
            var x = 0;
            var y = 0;
            if (engine.keys.up) {
                y += 4;
            }
            if (engine.keys.down) {
                y -= 4;
            }
            /*
            if (engine.keys.left) {
                x -= 4;
            }
            if (engine.keys.right) {
                x += 4;
            }
            */
            if (player.x + x + (player.width / 2) >= engine.width) {
                x = 0;
            }
            else if (player.x + x - (player.width / 2) <= 0) {
                x = 0;
            }
            if (player.y + y + (player.height / 2) >= engine.height) {
                y = 0;
            }
            else if (player.y + y - (player.height / 2) <= 0) {
                y = 0;
            }
            
            //player.x += x;
            player.y += y;
        });
        engine.sprites.add (player);

        /*
        TODO: Music, Sound
        int audio_frequency = 44100;
        uint16 audio_format = 0x8010; // 16-bit stereo?
        int audio_channels = 2;
        int audio_buffers = 4096;
        SDLMixer.open(audio_frequency, audio_format, audio_channels, audio_buffers);
        var music = new SDLMixer.Music("resources/112175__LS__Rain_on_my_buds74bpm.ogg");
        if (music != null) {
            music.play(100);
            //Mix_HookMusicFinished(musicDone);
        
            SDLMixer.close();
        }
        */
        
        var ball = new Ball(ref engine);
        ball.left_paddle = player;
        engine.sprites.add (ball);
                
        engine.run ();

        return 0;
    }
}
