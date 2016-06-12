package;

import game.*;
import game.entities.*;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

class Project {
	var shipL : Ship;
	var shipR : Ship;
	
	public function new() {
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		
		shipL = new Ship(Player.PLAYER_1);
		shipR = new Ship(Player.PLAYER_2);
		
		init();
	}

	function update(): Void {
		shipL.update();
		shipR.update();
	}

	function render(framebuffer: Framebuffer): Void {
		var g2 = framebuffer.g2;
		g2.begin(kha.Color.Black);
		g2.color = kha.Color.White;
		
		shipL.draw(g2);
		shipR.draw(g2);
		
		g2.end();
	}
	
	function init() : Void {
		shipL.positionCenter(System.windowWidth() / 2 - 2 * shipL.width, System.windowHeight() - shipL.height);
		shipR.positionCenter(System.windowWidth() / 2 + 2 * shipR.width, System.windowHeight() - shipR.height);
	}
}
