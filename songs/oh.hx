function onStartCountdown(event) {
	if (camHUD.width != 960){
		trace("yoylefake fix");
		FlxG.resetState();
	}
    event.cancel(true); 
	startSong();
	startedCountdown = true;
	if (startTimer == null) startTimer = new FlxTimer();
}

function onPostNoteCreation(_){
    _.note.forceIsOnScreen = true;
}

function postCreate() PauseSubState.script = "data/scripts/pause";

var prevHealthPerc;
function update() {
    prevHealthPerc = healthBar.percent;
}
function postUpdate() {
    healthBar.unbounded = true;
    healthBar.percent = CoolUtil.fpsLerp(prevHealthPerc, (health/healthBar.max) * 100, 0.3);
}