package;

import game.*;
import game.entities.*;
import game.ui.*;

import kha.Assets;
import kha.Font;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;
import kha.math.Random;

class Project {
	var shipL : Ship;
	var shipR : Ship;
	
	var asteroids : Group<Asteroid>;
	
	var timer : Timer;
	
	var font : Font;
	
	public function new() {
		System.notifyOnRender(render);
		Scheduler.addTimeTask(update, 0, 1 / 60);
		
		Random.init(Std.int(System.time));
		
		font = Assets.fonts.slkscr;
		
		shipL = new Ship(Player.PLAYER_1);
		shipR = new Ship(Player.PLAYER_2);
		
		asteroids = new Group<Asteroid>();
		for (i in 0...64) {
			var a = new Asteroid();
			asteroids.add(a);
		}
		
		timer = new Timer();
		
		init();
	}

	function update(): Void {
		shipL.update();
		shipR.update();
		asteroids.update();
		timer.update();
		
		asteroids.each(function (a : Asteroid) {
			if (a.checkCollision(shipL)) shipL.positionCenter(System.windowWidth() / 2 - 2 * shipL.width, System.windowHeight() - 64);
			if (a.checkCollision(shipR)) shipR.positionCenter(System.windowWidth() / 2 + 2 * shipR.width, System.windowHeight() - 64);
		});
		
		if (timer.y > System.windowHeight()) {
			init();
		}
	}

	function render(framebuffer: Framebuffer): Void {
		var g2 = framebuffer.g2;
		g2.begin(kha.Color.Black);
		g2.color = kha.Color.White;
		g2.font = font;
		
		shipL.draw(g2);
		shipR.draw(g2);
		asteroids.draw(g2);
		timer.draw(g2);
		
		g2.fontSize = 64;
		g2.drawString(Std.string(shipL.score), System.windowWidth() / 3, System.windowHeight() - 96);
		g2.drawString(Std.string(shipR.score), System.windowWidth() * 2 / 3, System.windowHeight() - 96);
		
		g2.fontSize = 16;
		g2.drawString("PLAYER 1: W - FORWARDS, S - BACKWARDS", 0, System.windowHeight() - 16);
		g2.drawString("PLAYER 2: O - FORWARDS, L - BACKWARDS", System.windowWidth() / 2 + 8, System.windowHeight() - 16);
		
		g2.end();
	}
	
	function init() : Void {
		shipL.positionCenter(System.windowWidth() / 2 - 2 * shipL.width, System.windowHeight() - 64);
		shipL.score = 0;
		shipR.positionCenter(System.windowWidth() / 2 + 2 * shipR.width, System.windowHeight() - 64);
		shipR.score = 0;
		asteroids.each(function (a : Asteroid) { a.init(); });
		timer.y = 0;
	}
}
