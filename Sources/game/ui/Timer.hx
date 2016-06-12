package game.ui;

import kha.graphics2.Graphics;
import kha.System;

class Timer extends game.Object {
    public function new() {
        super(System.windowWidth() / 2, 0, 10, System.windowHeight());
    }
    
    override public function update() {
        y += 0.5;
    }
    
    override public function draw(g : Graphics) {
        g.drawLine(x, y, x, height, width);
    }
}