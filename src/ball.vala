public class Ball : Darkcore.Sprite {
    public double velocity_x;
    public double velocity_y;
    public double acceleration {
        get; set; default = 0.100;
    }
    public Darkcore.Sprite? left_paddle { get; set; default = null; }
    public Darkcore.Sprite? right_paddle { get; set; default = null; }
    
    public Ball (ref Darkcore.Engine engine) {
        base.from_file (engine, "resources/ball.png");
        
        this.width = 64.00;
        this.height = 64.00;
        this.x = 100.00;
        this.y = 100.00;
        this.velocity_x = 2.00;
        this.velocity_y = 2.00;
        
        this.on_render = (engine, ball) => {
            var half_height = height / 2.00;
            var half_width = width / 2.00;
            if (y + half_height + velocity_y >= engine.height) {
                velocity_y = -Math.fabs(velocity_y);
            }
            if (y - half_height - velocity_y <= 0) {
                velocity_y = Math.fabs(velocity_y);
            }
            if (x + half_width + velocity_x >= engine.width) {
                velocity_x = -Math.fabs(velocity_x);
            }
            if (x - half_width - velocity_x <= 0) {
                velocity_x = Math.fabs(velocity_x);
            }
            
            if (left_paddle != null) {
            
            }
            
            foreach (var sprite in engine.sprites) {
                if (sprite == this) {
                    continue;
                }
                
                
                if (has_hit_paddle (sprite)) {
                    velocity_x = Math.fabs (velocity_x) + acceleration;
                    velocity_y = -((sprite.y - y) / 50);
                }
            }

            x += velocity_x;
            y += velocity_y;
            
            rotation += 1.0;
            
            
        };
    }
    
    public bool has_hit_paddle(Darkcore.Sprite sprite) {
        var circle_vector = new Darkcore.Vector(2);
        circle_vector.set (0, x);
        circle_vector.set (1, y);
        
        
        var min_vector = new Darkcore.Vector(2);
        var max_vector = new Darkcore.Vector(2);
        
        // Bottom Left
        min_vector.set (0, sprite.x - (sprite.width / 2));
        min_vector.set (1, sprite.y - (sprite.height / 2));
        
        // Top Right
        max_vector.set (0, sprite.x + (sprite.width / 2));
        max_vector.set (1, sprite.y + (sprite.height / 2));
        
        var hit = Darkcore.Collision.circle_in_rectangle (
            min_vector,
            max_vector,
            circle_vector,
            width / 2.00
        );
        
        return hit;
    }
}
