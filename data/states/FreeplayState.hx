import lime.app.Application;
import funkin.options.OptionsMenu;
import funkin.menus.credits.CreditsMain;
import funkin.menus.ModSwitchMenu;
import funkin.editors.EditorPicker;

function postCreate(){
	add(versionText = new FunkinText(5, FlxG.height - 2, 0, 'Codename Engine v' + Application.current.meta.get('version') + "\n[SHIFT] Open Mods menu\n[O] Open Options menu\n[C] Open Credits menu"));
	versionText.y -= versionText.height;
}

function update(){
	FlxG.camera.zoom = lerp(FlxG.camera.zoom,1,0.2);
	if (FlxG.keys.justPressed.SEVEN) {
		persistentUpdate = false;
		persistentDraw = true;
		openSubState(new EditorPicker());
	}
	if (FlxG.keys.justPressed.SHIFT) {
		openSubState(new ModSwitchMenu());
		persistentUpdate = false;
		persistentDraw = true;
	}
	if (FlxG.keys.justPressed.O) {
		FlxG.switchState(new OptionsMenu());
	}
	if (FlxG.keys.justPressed.C) {
		FlxG.switchState(new CreditsMain());
	}
}

function onChangeSelection(_){
	Conductor.changeBPM(songs[_.value].bpm);
}

function beatHit(){
	if (songInstPlaying)
		FlxG.camera.zoom += 0.05;
}