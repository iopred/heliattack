class SoundBoardTransform{
	var FADEIN:Number = 1;
	var FADEOUT:Number = 2;
	var FADETO:Number = 4;
	var STOPLOOP:Number = 8;
	
	var transformations:Array;
	
	var sb:SoundBoard;
	
	function SoundBoardTransform(sb:SoundBoard){
		this.sb = sb;
		this.transformations = new Array();
	}
	
	function addTransform(soundName:String,transform:Number,speed:Number,target:Number){
		for(var i:Number = 0;i < transformations.length;i++){
			if(transformations[i].soundName == soundName){
				clearInterval(transformations[i].interval)
				transformations[i] = null;
	
			}
		}
		
		
		
		var transformObj:Object = new Object();
		var interval:Number = setInterval(this, "doTransform",speed,transformations.length);
		transformObj.interval = interval;
		transformObj.soundName = soundName
		transformObj.transform = transform;
		transformObj.target = target;

		transformations.push(transformObj);
	
	}
	
	function addTransformStartLoop(soundName:String,transform:Number,speed:Number,target:Number){
	
		var started:Boolean = false;
		for(var i:Number = 0;i < transformations.length;i++){
			if(transformations[i].soundName == soundName){
				clearInterval(transformations[i].interval)
				transformations[i] = null;
				started = true;
			}
		}
		if(!started){
			sb.start(soundName,0,99999);
		}



		var transformObj:Object = new Object();
		var interval:Number = setInterval(this, "doTransform",speed,transformations.length);
		transformObj.interval = interval;
		transformObj.soundName = soundName
		transformObj.transform = transform;
		transformObj.target = target;

		transformations.push(transformObj);
		
	}
	
	function doTransform(intervalID:Number){
		
		var transform = transformations[intervalID]
		
		var trans = transform.transform;
		
		var soundVar:Sound = sb.getSound(transform.soundName);
			
		if(trans & FADEIN){
			soundVar.setVolume(soundVar.getVolume() + 1);
			
			if(soundVar.getVolume() >= transform.target){
				clearInterval(transform.interval)
				transformations[intervalID] = null;
				clearTransforms()
			}
			
		} else if(trans & FADEOUT){
			soundVar.setVolume(soundVar.getVolume() - 1);
			
			if(soundVar.getVolume() <= transform.target){
				soundVar.stop();
				clearInterval(transform.interval)
				transformations[intervalID] = null;
				clearTransforms()
			}
		} else if(trans & FADETO){
			if(soundVar.getVolume() > transform.target){
				soundVar.setVolume(soundVar.getVolume() - 1);
			} else {
				soundVar.setVolume(soundVar.getVolume() + 1);
			}
			
			if(soundVar.getVolume() == transform.target){
				clearInterval(transform.interval)
				transformations[intervalID] = null;
				clearTransforms()
			}
		} else if(trans & STOPLOOP){
			soundVar.stop();
			clearInterval(transform.interval)
			transformations[intervalID] = null;
			clearTransforms()
		}
		

	}
	
	function clearTransforms(){
		for(var i:Number = 0;i < transformations.length;i++){
			if(transformations[i] != null){
				return;
			}
		}
		transformations = new Array();
	}
	
}