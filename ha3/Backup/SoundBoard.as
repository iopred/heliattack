class SoundBoard {
	
	var active:Boolean;
	
	var sounds:Array;
	var soundsClip:MovieClip
	
	function SoundBoard(clip:MovieClip,depth:Number,active:Boolean) {
		this.sounds = new Array();
		this.soundsClip = clip.createEmptyMovieClip("SoundBoard"+depth,depth);
		this.active = active;
	}
	function attachSound(soundName:String):Sound {
		for (var i:Number = 0; i < this.sounds.length; i++) {
			if (this.sounds[i].soundName == soundName) {
				return this.sounds[i].soundVar;
			}
		}
		var soundHolder:Object = new Object();
	
		soundHolder.soundName = soundName;
		
		var soundTarget = this.soundsClip.createEmptyMovieClip(soundName,this.sounds.length);
		
		var soundVar = new Sound(soundTarget);
		soundVar.attachSound(soundName);
		
		soundHolder.soundVar = soundVar;
		
		this.sounds.push(soundHolder);

		return soundVar;
	}
	
	function getSound(soundName:String){
		for (var i:Number = 0; i<this.sounds.length; i++) {
			if (this.sounds[i].soundName == soundName) {
				return this.sounds[i].soundVar;
			}
		}
	}
	
	function start(soundName:String, secondsOffset:Number, loops:Number) {
		if(this.active){
			for (var i:Number = 0; i<this.sounds.length; i++) {
				if (this.sounds[i].soundName == soundName) {
					this.sounds[i].soundVar.stop();
					this.sounds[i].soundVar.start(secondsOffset, loops);
					break;
				}
			}
		}
	}
	
	function stop(soundName:String) {
		if(this.active){
			for (var i:Number = 0; i<this.sounds.length; i++) {
				if (this.sounds[i].soundName == soundName) {
					this.sounds[i].soundVar.stop();
					break;
				}
			}
		}
	}	
	
	function setVolume(soundName:String, vol:Number){
		for (var i:Number = 0; i<this.sounds.length; i++) {
			if (this.sounds[i].soundName == soundName) {
				this.sounds[i].soundVar.setVolume(vol);
			}
		}
	}
	
	function getVolume(soundName:String, vol:Number){
		for (var i:Number = 0; i<this.sounds.length; i++) {
			if (this.sounds[i].soundName == soundName) {
				return this.sounds[i].soundVar.getVolume();
			}
		}
	}
	
	function setPan(soundName:String, pan:Number){
		for (var i:Number = 0; i<this.sounds.length; i++) {
			if (this.sounds[i].soundName == soundName) {
				this.sounds[i].soundVar.setPan(pan);
			}
		}
	}
	
	function getPan(soundName:String, vol:Number){
		for (var i:Number = 0; i<this.sounds.length; i++) {
			if (this.sounds[i].soundName == soundName) {
				return this.sounds[i].soundVar.getPan();
			}
		}
	}
	
	function setTransform(soundName:String, trans:Object){
		for (var i:Number = 0; i<this.sounds.length; i++) {
			if (this.sounds[i].soundName == soundName) {
				this.sounds[i].soundVar.setTransform(trans);
			}
		}
	}
	
	function getTransform(soundName:String, vol:Number){
		for (var i:Number = 0; i<this.sounds.length; i++) {
			if (this.sounds[i].soundName == soundName) {
				return this.sounds[i].soundVar.getTransform();
			}
		}
	}
	
	function stopAllSounds() {
		for (var i:Number = 0; i<this.sounds.length; i++) {
			this.sounds[i].soundVar.stop();
		}
	}
	
	function setActive(active:Boolean){
		this.active = active;
		if(!this.active){
			this.stopAllSounds();
		}
	}
}
