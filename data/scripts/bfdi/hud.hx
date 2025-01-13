public var bars:FlxSprite;
public var timetxt:FlxText;
public var brothebar:FlxSprite;
public var brothedot:FlxSprite;
public var brothebart:FlxTween;
public var brothedott:FlxTween;
public var ythud:HudCamera;

function postCreate(){
    FlxG.cameras.add(ythud = new HudCamera(0, 0, 1280, 720), false);
    ythud.bgColor = 0;
    ythud.downscroll = true;

    insert(0,bars = new FlxSprite(0,0).loadGraphic(Paths.image('stages/bfdi/bars')));
    bars.cameras = [camHUD];

    add(timetxt = new FlxText(30, 30, FlxG.width, "", 0, true).setFormat("fonts/Shag-Lounge.otf", 25, 0xFF777777, "left"));
    timetxt.cameras = [ythud];

    add(brothebar = new FlxSprite(0,0).makeSolid(1, 10, 0xFFFF0000));
	brothebar.cameras = [ythud];

    add(brothedot = new FlxSprite(-10,-5).loadGraphic(Paths.image('stages/bfdi/reddot')));
    brothedot.scale.set(0.5,0.5);
    brothedot.updateHitbox();
	brothedot.cameras = [ythud];

    brothebart = FlxTween.tween(brothebar.scale, {x: FlxG.width*2}, Std.int((inst.length) / 1000));
    brothedott = FlxTween.tween(brothedot, {x: FlxG.width}, Std.int((inst.length) / 1000));
}

function onNoteHit(_){
    _.ratingPrefix = "stages/bfdi/";
}

function onNoteCreation(_){
    _.noteSprite = "stages/bfdi/NOTE_assets";
}
function onStrumCreation(_){
    _.sprite = "stages/bfdi/NOTE_assets";
}

function onPostNoteCreation(_) {
    _.note.forceIsOnScreen = true;
	_.note.splash = "bfdi";
}

function postUpdate(){
    if (Conductor.songPosition >= 0){
        timetxt.text = Std.int(Std.int((Conductor.songPosition) / 1000) / 60) + ":" + CoolUtil.addZeros(Std.string(Std.int((Conductor.songPosition) / 1000) % 60), 2) + "/" + Std.int(Std.int((inst.length) / 1000) / 60) + ":" + CoolUtil.addZeros(Std.string(Std.int((inst.length) / 1000) % 60), 2);
	}
}