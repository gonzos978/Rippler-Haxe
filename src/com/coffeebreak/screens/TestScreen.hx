package com.coffeebreak.screens;

import com.coffeebreak.core.BaseScreen;
import com.coffeebreak.effects.Rippler;
import flash.display.BitmapData;
import flash.filters.DisplacementMapFilter;
import flash.geom.Point;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.filters.BitmapFilter;
import openfl.filters.DisplacementMapFilterMode;
import openfl.utils.Assets;
import openfl.utils.Object;

/**
 * ...
 * @author ...
 */
class TestScreen extends BaseScreen 
{
	private var _target : Bitmap;
    private var _rippler : Rippler;
	
	private var dis:DisplacementMapFilter;
	private var pOffset:Array<Point>;
	
	//
	private var bmpTarget:BmpTarget;
	public var counter:Int;
	public var pt:Point;
	public var mpoint:Point;
	public var myBitmap:BitmapData;
	public var myDispl:DisplacementMapFilter;
	public var myList:Array<BitmapFilter>;
	
	
	var offsets:Array <Point > ;
	public function new() 
	{
		super();
		
		
		 _target = new Bitmap(Assets.getBitmapData("img/shallow-water.png"));
         addChild(_target);
		 
		 bmpTarget = new BmpTarget();
		// addChild(bmpTarget);
          
		// third();
        // create the Rippler instance to affect the Bitmap object
         _rippler = new Rippler(_target, 60, 6);
            
        // create the event listener for mouse movements
        CoffeeConstants.STAGE.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
		
	  // testAnotgerExample(_target.bitmapData);
	}
	
	 // creates a ripple at mouse coordinates on mouse movement
	private function handleMouseMove(event : MouseEvent) : Void
	{
		// the ripple point of impact is size 20 and has alpha 1
		_rippler.drawRipple(Std.int(_target.mouseX), Std.int(_target.mouseY), 20, 1);
	}
	
	private function testAnotgerExample(_bmp:BitmapData):Void
	{
		dis = new DisplacementMapFilter(_bmp, new Point(), 1, 2, 10, 60);
		var pt1:Point = new Point(0, 0);
		var pt2:Point = new Point(0, 0);
		pOffset = [pt1, pt2];
		
		CoffeeConstants.STAGE.addEventListener(MouseEvent.MOUSE_MOVE, handleAnimation);
	}
	
	function handleAnimation(e:MouseEvent):Void 
	{
		pOffset[0].x += 1;
		pOffset[1].y += .1;
		
		_target.bitmapData.perlinNoise(45, 9, 2, 50, true, false, 7, true, pOffset);
		_target.filters = [dis];
	}
	
	function createWater():Void
	{
		counter = 1;
		pt = new Point(0, 0);
		mpoint = new Point(0, 0);
		myBitmap = new BitmapData(Std.int(bmpTarget.width), Std.int(bmpTarget.height), false, 0);

		myDispl = new DisplacementMapFilter(myBitmap, mpoint, 10, 2, 10, 15, "clamp");
		
		myList = [];
		myList.push(myDispl);
		filters = myList;// [new DisplacementMapFilter()];
		
		CoffeeConstants.STAGE.addEventListener(Event.ENTER_FRAME, onFIlter);
		
	}
		
	private function onFIlter(e) 
	{
			 
			 
			var offset = [];
			offset[1] = new Point();
			offset[1].x = counter;
			offset[1].y = counter/8;
			myBitmap.perlinNoise(45,5,3,50,true,false,7,true,offset);
			cast(myList[0],DisplacementMapFilter).mapBitmap = myBitmap;
			bmpTarget.filters = myList;
		
			bmpTarget.counter++;
	
	}
	
	private function third():Void
	{
		myBitmap = new BitmapData(Std.int(bmpTarget.width), Std.int(bmpTarget.height));  
		dis = new DisplacementMapFilter(myBitmap,new Point(0,0),1,2,20,25, DisplacementMapFilterMode.CLAMP);  
		offsets = [new Point(0, 0), new Point(0, 0)];  
		  
		CoffeeConstants.STAGE.addEventListener(Event.ENTER_FRAME, doUpdate);  
		 
	}
	
	private function doUpdate(evt:Event):Void   
	{  
	  offsets[0].x -=4;  
	  offsets[1].y -=1;  
	  myBitmap.perlinNoise(45, 20, 2 ,50, true, false, 7, true, offsets);  
	  bmpTarget.filters = [dis];
	}
	
	
}