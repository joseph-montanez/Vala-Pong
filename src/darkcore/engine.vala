using SDL;
using SDLGraphics;
using GL;
using GLU;
using GLUT;

namespace Darkcore { public class Engine : Object {
    public delegate void DelegateType (Engine world);
    /* Vala 0.12 does not support an array of delegations :( */
    public DelegateType? on_loop_events_00;
    public DelegateType? on_loop_events_01;
    public DelegateType? on_loop_events_02;
    public DelegateType? on_loop_events_03;
    public DelegateType? on_loop_events_04;
    public Gee.ArrayList<Texture*> textures; 
    public Gee.ArrayList<Sprite> sprites; 
    public GLuint tids[32];
    public KeyState keys;
    public Sprite player;
    public unowned SDL.Screen screen;
    public bool done;
    public int width;
    public int height;
    
    public Engine(int width, int height) {
        SDL.init (InitFlag.VIDEO |  InitFlag.AUDIO);
        this.textures = new Gee.ArrayList<Texture>();
        this.sprites = new Gee.ArrayList<Sprite>();
        this.keys = new KeyState();
        this.width = width;
        this.height = height;
        
        this.init_video ();
    }
    
    public int add_event_on_loop (DelegateType fn) {
        /* 
            This is fking retarded, i want delegations to be allowed with an 
            array type!!!
        */
        
        if (this.on_loop_events_00 == null) {
            this.on_loop_events_00 = fn;
            return 0;
        }
        if (this.on_loop_events_01 == null) {
            this.on_loop_events_01 = fn;
            return 1;
        }
        if (this.on_loop_events_02 == null) {
            this.on_loop_events_02 = fn;
            return 2;
        }
        if (this.on_loop_events_03 == null) {
            this.on_loop_events_03 = fn;
            return 3;
        }
        if (this.on_loop_events_04 == null) {
            this.on_loop_events_04 = fn;
            return 4;
        }
        
        return -1;
    }
    
    public void process_events () {
        Event event = Event ();
        while (Event.poll (event) == 1) {
            switch (event.type) {
            case EventType.QUIT:
                this.done = true;
                break;
            case EventType.KEYDOWN:
                this.on_keyboard_event (event.key, true);
                break;
            case EventType.KEYUP:
                this.on_keyboard_event (event.key, false);
                break;
            }
        }
    }

    public void on_keyboard_event (KeyboardEvent event, bool isdown) {
        switch (event.keysym.sym) {
            case KeySymbol.SPACE:
                this.keys.space = isdown;
                break;
            case KeySymbol.UP:
                this.keys.up = isdown;
                break;
            case KeySymbol.DOWN:
                this.keys.down = isdown;
                break;
            case KeySymbol.LEFT:
                this.keys.left = isdown;
                break;
            case KeySymbol.RIGHT:
                this.keys.right = isdown;
                break;
            case KeySymbol.ESCAPE:
                this.done = true;
                break;
        }
        
        if (isdown && is_alt_enter (event.keysym)) {
            WindowManager.toggle_fullscreen (screen);
        }
    }

    public static bool is_alt_enter (Key key) {
        return ((key.mod & KeyModifier.LALT)!=0)
            && (key.sym == KeySymbol.RETURN
                    || key.sym == KeySymbol.KP_ENTER);
    }

    public void init_video () {
        var bpp = VideoInfo.get().vfmt.BitsPerPixel;

        SDL.GL.set_attribute(SDL.GLattr.RED_SIZE, 5);
        SDL.GL.set_attribute(SDL.GLattr.GREEN_SIZE, 5);
        SDL.GL.set_attribute(SDL.GLattr.BLUE_SIZE, 5);
        SDL.GL.set_attribute(SDL.GLattr.DEPTH_SIZE, 16);
        SDL.GL.set_attribute(SDL.GLattr.DOUBLEBUFFER, 1);

        uint32 video_flags = SurfaceFlag.OPENGL;

        this.screen = Screen.set_video_mode (this.width, this.height,
                                             bpp, video_flags);
        if (this.screen == null) {
            stderr.printf ("Could not set video mode.\n");
        }

        SDL.WindowManager.set_caption ("TODO: Allow Title", "");
        
        glShadeModel(GL_SMOOTH);
        glCullFace(GL_BACK);
        glFrontFace(GL_CCW);
        glEnable(GL_CULL_FACE);
        glClearColor(0, 0, 0, 0);
        glViewport(0, 0, (GL.GLsizei) this.screen.w, (GL.GLsizei) this.screen.h);
        glMatrixMode(GL_PROJECTION);
        glLoadIdentity();
        
        glOrtho(0,this.screen.w,0,this.screen.h,-100,100);
        
        glGenTextures(32, this.tids);
        
    }
    

    public void draw () {
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        glMatrixMode(GL_MODELVIEW);
        glLoadIdentity();
        // This is where the camera would translate
        glTranslated(0, 0, -10);
        
        /*
        TODO: Add tile based map support
        Texture? tex = null;
        if (this.textures.size > 0) {
            tex = this.textures.get(0);
        }
        glEnable(GL_TEXTURE_2D);
        if (tex != null && tex.loaded > 0) {
            glBindTexture(GL_TEXTURE_2D, this.tids[tex.texture_id]);
        }
        
        var px = 16;
        var py = 16;
        var pz = 0;
        glBegin(GL_QUADS);
            glColor3d(1.0, 1.0, 1.0);
            glTexCoord2f((GLfloat) 0.00, (GLfloat) 0.00); 
            glVertex3i(-px,  py, pz);
            glTexCoord2f((GLfloat) 0.50, (GLfloat) 0.00);
            glVertex3i(-px, -py, pz);
            glTexCoord2f((GLfloat) 0.50, (GLfloat) 0.50); 
            glVertex3i( px, -py, pz);
            glTexCoord2f((GLfloat) 0.00, (GLfloat) 0.50); 
            glVertex3i( px,  py, pz);
        glEnd();
        
        if (tex != null && tex.loaded > 0) {
            glBindTexture(GL_TEXTURE_2D, (GLuint) 0);
        }
        
        glDisable(GL_TEXTURE_2D);
        */
        
        foreach (var sprite in this.sprites) {
            if (sprite.on_render != null) {
                sprite.fire_render(sprite.on_render, this, sprite);
            }
            sprite.render();
        }

        SDL.GL.swap_buffers();
    }
    
    public void run () {
        this.render();
        SDL.quit ();
    }

    public void render () {
        var old_time = SDL.Timer.get_ticks();
        int fps = 0;
        int minticks = 1000 / 60;

        while (!this.done) {
            var new_time = SDL.Timer.get_ticks();
            var time_since_last_frame = new_time - old_time;
            
            this.process_events ();

            foreach (var sprite in this.sprites) {
                if (sprite.on_key_press != null) {
                    sprite.fire_key_press(sprite.on_key_press, this, sprite);
                }
            }           
             
            this.draw ();
            fps++;
            
            SDL.Timer.delay(minticks);
                
            // If all works well you should get about 30 frames a second
            if (time_since_last_frame > 1000) {
                print("FPS: %i\n", fps);
                old_time = new_time;
                fps = 0;
            }
        }    
    }
    
    public Texture? getTexture(int index) {
        Texture? texture = null;
        if (index < this.textures.size) {
            texture = this.textures.get(index);
        }
        
        return texture;
    }
    
    public int addTexture(string filename) {
        this.textures.add(new Texture.from_file(filename, this));
        return this.textures.size - 1;
    }
}}