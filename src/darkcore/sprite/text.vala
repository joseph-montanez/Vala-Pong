namespace Darkcore {
    namespace SpriteNS {
        public class Text : Sprite {
            public Text() {
                base();
            }
            public Text.from_texture(Engine world, int texture_index) {
                base.from_texture(world, texture_index);
            }
            public override void render() {
                var fw = 1.00 / (512.0 / 32.0);
                
                var word = "Hello!";
                var i = 0;
                var pword = word;
                var c = pword.get_char ();
                while (c != '\0') {
                    //print ("- %s = %i\n", c.to_string (), (int) c);
                    var ord = (int) c;
                    
                    int cy = ord / 16; 
                    int cx = ord % 16;
                    this.width = 32;
                    this.height = 32;
                    this.x = 230 + (16 * i);
                    this.y = 200; // + (16 * i);
                    
                    this.coords_top_left_x = 0.00 + (fw * cx);
                    this.coords_top_left_y = 0.00 + (fw * cy);
                    
                    this.coords_bottom_left_x = fw + (fw * cx);
                    this.coords_bottom_left_y = 0.00 + (fw * cy);
                    
                    this.coords_top_right_x = 0.00 + (fw * cx);
                    this.coords_top_right_y = fw + (fw * cy);
                    
                    this.coords_bottom_right_x = fw + (fw * cx);
                    this.coords_bottom_right_y = fw + (fw * cy);
                    
                    pword = pword.next_char ();
                    c = pword.get_char ();
                    i++;
                    base.render();
                }
            }
        }
    }
}
