package game.entities;

import kha.System;
import kha.graphics2.Graphics;
import kha.math.Random.Default;

class Asteroid extends game.Entity {
    var dx : Int;
    var v : Float;
    
    public function new() {
        super(0, 0, 8, 4);
        
        v = 2;
    }
    
    override public function update() : Void {
        x += dx * v;
        
        if ((dx == -1) && (x < -width)) {
            x = System.windowWidth() + width;
        }
        
        if ((dx == 1) && (x > (System.windowWidth() + width))) {
            x = -width;
        }
    }
    
    override public function draw(g : Graphics) : Void {
        g.fillRect(x, y, width, height);
    }
    
    public function init() {
        x = Default.GetFloatIn(0, System.windowWidth());
        y = Default.GetFloatIn(0, System.windowHeight() - 128);
        dx = Default.GetIn(0, 1) == 0 ? 1 : -1;
    }
    
    public function checkCollision(s : Ship) : Bool {
        return this.overlapsEntity(s);
    }
}
