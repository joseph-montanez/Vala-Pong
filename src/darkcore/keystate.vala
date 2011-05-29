using SDL;
using SDLGraphics;
using GL;
using GLU;
using GLUT;

namespace Darkcore { public class KeyState : Object {
    public bool up { get; set; default = false; }
    public bool down { get; set; default = false; }
    public bool left { get; set; default = false; }
    public bool right { get; set; default = false; }
    public bool space { get; set; default = false; }
    public KeyState() {
    
    }
    
    public bool is_up () {
        return this.up;
    }
}}
