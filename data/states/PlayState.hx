import funkin.backend.utils.DiscordUtil;

function create() {
    allowGitaroo = false;
}

function postUpdate() {
    if (startingSong || !canPause || paused || health <= 0) return;
    updateSpeed(FlxG.keys.pressed.TWO);

    if (health > 0.01){
	    DiscordUtil.changePresenceAdvanced({
	    	state: (PlayState.instance.paused ? "Paused - " : "") + PlayState.SONG.meta.displayName + ' - ' + Std.int(Std.int((Conductor.songPosition) / 1000) / 60) + ":" + CoolUtil.addZeros(Std.string(Std.int((Conductor.songPosition) / 1000) % 60), 2) + "/" + Std.int(Std.int((PlayState.instance.inst.length) / 1000) / 60) + ":" + CoolUtil.addZeros(Std.string(Std.int((PlayState.instance.inst.length) / 1000) % 60), 2),
	    	details: 'Score:' + PlayState.instance.songScore + ' | Misses:' + PlayState.instance.misses,
            largeImageKey: PlayState.SONG.meta.name,
	    	smallImageKey: "https://media.tenor.com/Iqj4GVV1M4sAAAAj/mizuki-akiyama-mizuki.gif"
	    });
    }
}

function updateSpeed(fast:Bool) {
    FlxG.timeScale = inst.pitch = vocals.pitch = (player.cpu = fast) ? 10 : 1;
    health = !(canDie != fast) ? 2 : health;
}

function onGamePause() {updateSpeed(false);}
function onSongEnd() {updateSpeed(false);}
function destroy() {FlxG.timeScale = 1;FlxG.sound.muted = false;}