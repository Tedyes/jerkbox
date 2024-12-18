import openfl.display.BlendMode;
var yapperwords:Array<String> = ['QUITTER.','QUIT.','STOP.','END IT.'];
function postCreate(){
    camZoomingInterval = 9999999;
    VHScam = new FlxCamera();
    VHScam.bgColor = 0;
    FlxG.cameras.add(VHScam, false);
    VHS.cameras = [VHScam];
    VHS.updateHitbox();
    VHS.blend = BlendMode.ADD;

    fuckassword = new FlxText(-275,300, FlxG.width, "");
	fuckassword.setFormat(Paths.font("PetscopTall.ttf"), 50, FlxColor.WHITE, "center");
    add(fuckassword);
}

function onCameraMove(e) {
    fuckassword.alpha = lerp(fuckassword.alpha,0.0001,0.15);
    camFollow.setPosition(200,300);
    FlxG.camera.snapToTarget();
    e.cancel();
}

function beatHit(){
    if (curBeat % 2 == 0){
        fuckassword.setPosition(-275 + FlxG.random.int(-300,300),300 + FlxG.random.int(-300,300));
        fuckassword.text = yapperwords[FlxG.random.int(0,3)];
        fuckassword.alpha = 1;
    }
}