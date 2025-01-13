var dadIsSustainNote:Bool;
var dadDirection:Int;
var bfIsSustainNote:Bool;
var bfDirection:Int;
var p1holdtimer:FlxTimer;
var p2holdtimer:FlxTimer;

function create(){
    p1holdtimer = new FlxTimer().start(0.01, function(tmr:FlxTimer) {dadIsSustainNote = false;}, 0);
    p2holdtimer = new FlxTimer().start(0.01, function(tmr:FlxTimer) {bfIsSustainNote = false;}, 0);
}

function onDadHit(e){
    if(e.note.isSustainNote) {
        e.preventAnim();
        dadDirection = e.direction;
        dadIsSustainNote = true;
        p1holdtimer.reset(0.01);
    }
    else dadIsSustainNote = false;
}

function onPlayerHit(e){
    if(e.note.isSustainNote) {
        e.preventAnim();
        bfDirection = e.direction;
        bfIsSustainNote = true;
        p2holdtimer.reset(0.01);
    }
    else bfIsSustainNote = false;
}

function update(){

    if(dadIsSustainNote){
        dad.playSingAnim(dadDirection,true);
    }
    if(bfIsSustainNote){
        boyfriend.playSingAnim(bfDirection,true);
    }
}

function onStartCountdown(event) {
    event.cancel(true); 
	startSong();
	startedCountdown = true;
	if (startTimer == null)
		startTimer = new FlxTimer();
}