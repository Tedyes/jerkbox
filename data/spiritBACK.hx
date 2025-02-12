import flixel.addons.effects.FlxTrail;

var self = this;
var trail:FlxTrail;
function postCreate() {
	trail = new FlxTrail(self, null, 40, 10, 0.3, 0.1);
}

var toAdd:Bool = true;
function update(elpased) {
	if(toAdd) {
		toAdd = false;
		PlayState.instance.insert(PlayState.instance.members.indexOf(self), trail);
		disableScript();
	}
}