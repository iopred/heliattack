/**
 ** This module defines the game TrackingSingleton object. Only one instance allowed per application.
 ** Its purpose is to provide the programmer a consistent and abstract interface for tracking game
 ** events with a web server metric service.
 **
 ** Usage:
 **
 ** Add TrackingSingleton.as to your project.
 **
 ** Call getInstance() to get a reference to the tracking interface:
 **   var myObj:TrackingSingleton = TrackingSingleton.getInstance();
 **
 ** Call sendhit() anytime a trackable event occurs in the game:
 **   myObj.sendHit(TrackingSingleton.Load, ""); -- when game is loaded and ready to play
 **   myObj.sendHit(TrackingSingleton.Play, ""); -- when user begins a new game
 **   myObj.sendHit(TrackingSingleton.GameOver, ""); -- when game is complete
 **   myObj.sendHit(TrackingSingleton.ZoneChange, "L1"); -- when game milestone is reached.
 **
 ** Game milestones are game dependent, depending on game design and what the game producer wants to track.
 ** Examples are Level reached, pickup earned, power-up used, etc. The data parameter is used to identify
 ** which milestone.
 **
 ** In Flash the tracking events are passed to the browser's JavaScript engine via a call to the function
 ** TrackingEvent(Number,String);
 **/

import flash.external.ExternalInterface;

class TrackingSingleton
{
    private static var instance:TrackingSingleton = null;
	private var firstEventTime:Date = null;
	private var lastEventTime:Date = null;
	private var hitCounter:Number = 0;
	private var flashVersion:Number = 0;
	
	public static var Load:Number = 1;
	public static var Play:Number = 2;
	public static var GameOver:Number = 3;
	public static var ZoneChange:Number = 4;
	
    public function sendHit(hitType:Number, hitData:String):Boolean
	{
		if (flashVersion == 0)
		{
			flashVersion = getFlashMajorVersion();
		}
		hitCounter ++;
		if (firstEventTime == null)
		{
			firstEventTime = new Date();
			lastEventTime = firstEventTime;
		}
		else
		{
			lastEventTime = new Date();
		}
		// if (flashVersion >= 8)
		// {
		//	ExternalInterface.call("TrackingEvent", hitType, escape(hitData) );
		//	trace("ExternalInterface.call(\"TrackingEvent\", " + hitType + ", " + escape(hitData) + ");");
		// }
		// else
		// {
			getURL("javascript:trackingEvent(" + hitType + ", \"" + escape(hitData) + "\");");
			trace("javascript:trackingEvent(" + hitType + ", \"" + escape(hitData) + "\");");
		// }
		return(true);
    }
	
    public static function getInstance():TrackingSingleton
	{
        if (TrackingSingleton.instance == null)
		{
            TrackingSingleton.instance = new TrackingSingleton();
        }
        return TrackingSingleton.instance;
    }

    public static function getVersionString():String
	{
        return "1.0.1";
    }

    public function asString():String
	{
        return "TrackingSingleton version " + getVersionString();
    }
	
	public function getFlashMajorVersion():Number
	{
		// Flash getVersion returns a string like WIN 8,0,1,0 and we just want the major version
		// number (in this case 8)
		var majorVersion:Number = 0;
		var strList:Array = new Array();
		strList = getVersion().split(" ");
		if (strList.length >= 2)
		{
			strList = strList[1].split(",");
			majorVersion = strList[0];
		}
		return majorVersion;
	}
}

