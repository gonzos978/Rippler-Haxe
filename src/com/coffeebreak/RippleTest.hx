package com.coffeebreak;

import com.coffeebreak.effects.Rippler;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.utils.Assets;

/**
 * ...
 * @author gonzos
 */
class RippleTest extends Sprite
{
	
	private var _target : Bitmap;
    private var _rippler : Rippler;

	public function new() 
	{
		super();
		
		 _target = new Bitmap(Assets.getBitmapData("img/shallow-water.png"));
         addChild(_target);
		 
		 // create the Rippler instance to affect the Bitmap object
         _rippler = new Rippler(_target, 60, 6);
		 
		 addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}
	
	public function onAddedToStage(e:Event):Void
	{

		
		this.stage.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
		
	}	
	
	 // creates a ripple at mouse coordinates on mouse movement
	private function handleMouseMove(event : MouseEvent) : Void
	{
		trace("move....");
		// the ripple point of impact is size 20 and has alpha 1
		_rippler.drawRipple(Std.int(_target.mouseX), Std.int(_target.mouseY), 20, 1);
	}
	
	
}