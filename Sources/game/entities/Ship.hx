package game.entities;

import game.Entity;
import game.Player;

import kha.Key;
import kha.System;
import kha.graphics2.Graphics;
import kha.input.Keyboard;

class Ship extends Entity {
    var dy : Int;
    var v : Float;
    var player : Player;
    
    public function new(player : Player) {
        super(0, 0, 32, 32);
        
        this.player = player;
        
        dy = 0;
        v = 4;
        
        if (Keyboard.get() != null) Keyboard.get().notify(onKeyDown, onKeyUp);
    }
    
    override public function update() : Void {
        y += dy * v;
        
        if ((dy == 1) && (y > (System.windowHeight() - height))) {
            y = System.windowHeight() - height;
        }
        
        if (y < (0 - height)) {
            y = System.windowHeight();
        }
    }
    
    override public function draw(g : Graphics) : Void {
        // Head
        g.drawLine(x + 16, y, x + 4, y + 12);
        g.drawLine(x + 4, y + 12, x + 8, y + 12);
        g.drawLine(x + 16, y, x + 28, y + 12);
        g.drawLine(x + 28, y + 12, x + 24, y + 12);
        // Body
        g.drawLine(x + 8, y + 12, x + 8, y + 16);
        g.drawLine(x + 24, y + 12, x + 24, y + 16);
        // Tail
        g.drawLine(x + 8, y + 16, x, y + 28);
        g.drawLine(x, y + 28, x + 4, y + 28);
        g.drawLine(x + 24, y + 16, x + 32, y + 28);
        g.drawLine(x + 32, y + 28, x + 28, y + 28);
        g.drawLine(x + 12, y + 28, x + 20, y + 28);
        // Left thruster
        g.drawLine(x + 4, y + 28, x + 4, y + 32);
        g.drawLine(x + 4, y + 32, x + 12, y + 32);
        g.drawLine(x + 12, y + 32, x + 12, y + 28);
        // Right thruster
        g.drawLine(x + 28, y + 28, x + 28, y + 32);
        g.drawLine(x + 28, y + 32, x + 20, y + 32);
        g.drawLine(x + 20, y + 32, x + 20, y + 28);
    }
    
    private function onKeyDown(key : Key, char : String) : Void {
        if (player == Player.PLAYER_1) {
            switch (char) {
                case "w": dy = -1;
                case "s": if ((y + height) < System.windowHeight()) dy = 1;
            }
        } else {
            switch (char) {
                case "o": dy = -1;
                case "l": if ((y + height) < System.windowHeight()) dy = 1;
            }
        }
    }
    
    private function onKeyUp(key : Key, char : String) : Void {
        if (player == Player.PLAYER_1) {
            switch (char) {
                case "w": dy = 0;
                case "s": dy = 0;
            }
        } else {
            switch (char) {
                case "o": dy = 0;
                case "l": dy = 0;
            }
        }
    }
}
