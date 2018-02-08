package game.entities;

import kha.System;
import kha.graphics2.Graphics;
import kha.input.Keyboard;
import kha.input.KeyCode;

import game.Player;
import game.Entity;

class Ship extends Entity {
    var dy:Int;
    var v:Float;
    var player:Player;
    
    public var score:Int;
    
    public function new(player:Player){
        super(0, 0, 32, 32);
        
        this.player = player;
        
        dy = 0;
        v = 4;
        score = 0;
        
        if (Keyboard.get() != null) Keyboard.get().notify(onKeyDown, onKeyUp);
    }
    
    override public function update():Void {
        y += dy * v;
        
        if ((dy == 1) && (y > (System.windowHeight() - height))){
            y = System.windowHeight() - height;
        }
        
        if (y < (0 - height)) {
            y = System.windowHeight();
            score += 1;
        }
    }
    
    override public function draw(g:Graphics):Void {
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

    private function onKeyDown(keyCode:KeyCode):Void {
        if (player == Player.PLAYER_1) {
            switch (keyCode) {
                case KeyCode.W: dy = -1;
                case KeyCode.S: if ((y + height) < System.windowHeight()) dy = 1;
            default: return;
            }
        } else {
            switch (keyCode) {
                case KeyCode.O: dy = -1;
                case KeyCode.L: if ((y + height) < System.windowHeight()) dy = 1;
            default: return;
            }
        }
    }
    
    private function onKeyUp(keyCode:KeyCode):Void {
        if (player == Player.PLAYER_1) {
            switch (keyCode){
                case KeyCode.W: dy = 0;
                case KeyCode.S: dy = 0;
            default: return;
            }
        } else {
            switch (keyCode) {
                case KeyCode.O: dy = 0;
                case KeyCode.L: dy = 0;
            default: return;
            }
        }
    }
}
