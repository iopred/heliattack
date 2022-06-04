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
		sb.start(soundName,0,99999,true);
		sbt.addTransform(soundName,sbt.FADEIN,speed,vol);
		
		this.music = soundName;
		
	}
	
	function stop(speed:Number){
		sbt.addTransform(this.music,sbt.FADEOUT,speed,0);
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
		sb.start(soundName,0,99999,true);
		
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
		
				
		this.music = soundName2;

		
		var newMusic = sb.getSound(soundName);
		
		newMusic.onSoundComplete = function(){
			_root.sb.start(soundName2,0,99999,true);			
		}
		
		sb.start(soundName,0,0,true);
				
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
				sb.start(this.music,0,99999,true);
				sbt.addTransform(this.music,sbt.FADEIN,5,this.vol);
			}
		} else {
			this.stop(1);
		}
	}
}