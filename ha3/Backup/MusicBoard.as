class MusicBoard{
	var sb:SoundBoard;
	var sbt:SoundBoardTransform;
	var music:String;
	var vol:Number;
	var active:Boolean;
	
	function MusicBoard(sb:SoundBoard,sbt:SoundBoardTransform,active:Boolean){
		this.sb = sb;		
		this.sbt = sbt;
		this.music = null;
		this.vol = 0;
		this.active = active;		
	}
	
	function start(soundName:String,speed:Number,vol:Number){
		
		this.vol = vol
		
		if(!this.active){
			this.music = soundName;
			return;
		}
		
		if(soundName == this.music){
			sbt.addTransform(soundName,sbt.FADETO,speed,vol);

			return;
			
		} else if(this.music != null){
			sbt.addTransform(this.music,sbt.FADEOUT,speed,0);
		}
		
		
		sb.setVolume(soundName,0);
		sb.start(soundName,0,99999);
		sbt.addTransform(soundName,sbt.FADEIN,speed,vol);
		
		this.music = soundName;
		
	}
	
	function instantStart(soundName:String,vol:Number){
		
		this.vol = vol
		
		if(!this.active){
			this.music = soundName;
			return;
		}

		if(soundName == this.music){
			sb.setVolume(soundName,vol);
			return;

		} else if(this.music != null){
			sb.stop(this.music);
		}

		sb.setVolume(soundName,vol);
		sb.start(soundName,0,99999);
		
		this.music = soundName;
		
	}
	
	function instantIntroStart(soundName:String,soundName2:String,vol:Number){
		
		this.vol = vol
				
		if(!this.active){
			this.music = soundName;
			return;
		}

		if(soundName == this.music){
			sb.setVolume(soundName,vol);
			return;

		} else if(this.music != null){
			sb.stop(this.music);
		}

		sb.setVolume(soundName,vol);
		sb.setVolume(soundName2,vol);
		sb.start(soundName,0,99999);
				
		this.music = soundName;

		
		var newMusic = sb.getSound(soundName);
		
		newMusic.onSoundComplete = function(){			
			sb.start(soundName,99999);
			this.onSoundComplete = null;
			
		}
		
	}
	
	function setActive(active:Boolean){
		
		
		var oldActive:Boolean = this.active;
		
		this.active = active;
		
		
		if(this.music == null){
			return;
		}
		
		if(this.active){
			if(!oldActive){
				sb.setVolume(this.music,0);
				sb.start(this.music,0,99999);
				sbt.addTransform(this.music,sbt.FADEIN,10,this.vol);
			}
		} else {
			sbt.addTransform(this.music,sbt.FADEOUT,1,0);
		}
	}
}