package;

import game.*;
import game.entities.*;

import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.math.Random;

class Project {
	var shipL : Ship;
	var shipR : Ship;
	
	var asteroids : Group<Asteroid>;
	
	public function new() {
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		
		Random.init(20160612);
		
		shipL = new Ship(Player.PLAYER_1);
		shipR = new Ship(Player.PLAYER_2);
		
		asteroids = new Group<Asteroid>();
		
		init();
	}

	function update(): Void {
		shipL.update();
		shipR.update();
		asteroids.update();
	}

	function render(framebuffer: Framebuffer): Void {
		var g2 = framebuffer.g2;
		g2.begin(kha.Color.Black);
		g2.color = kha.Color.White;
		
		shipL.draw(g2);
		shipR.draw(g2);
		asteroids.draw(g2);
		
		g2.end();
	}
	
	function init() : Void {
		shipL.positionCenter(System.windowWidth() / 2 - 2 * shipL.width, System.windowHeight() - shipL.height);
		shipR.positionCenter(System.windowWidth() / 2 + 2 * shipR.width, System.windowHeight() - shipR.height);
		
		for (i in 0...64) {
			var a = new Asteroid();
			a.init();
			asteroids.add(a);
		}
	}
}
