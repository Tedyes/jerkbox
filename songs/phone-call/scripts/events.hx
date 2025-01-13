function create(){
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(barcam = new FlxCamera(), false);
    barcam.bgColor = 0;
    FlxG.cameras.add(camHUD, false);
    FlxG.cameras.add(ilovegaycam = new FlxCamera(), false);
    ilovegaycam.bgColor = FlxColor.BLACK;
    FlxG.cameras.add(p2cam = new HudCamera(), false);
    p2cam.bgColor = 0;
    p2cam.downscroll = Options.downscroll;
    p2cam.alpha = 0.25;
    p2cam.x += 500;
    strumLines.members[0].cameras = [p2cam];

    add(bar = new FlxSprite().loadGraphic(Paths.image("stages/phoneCallStreet/BLACKBARS")));
    bar.cameras = [barcam];
    bar.scale.set(1,1.25);

    stage.getSprite("introText").cameras = [ilovegaycam];
    stage.getSprite("introText").screenCenter();
    stage.getSprite("introText").y -= 25;
    stage.getSprite("introText").alpha = 0.001;
    camHUD.alpha = 0.001;
}

function onNoteCreation(_){
    _.noteSprite = "stages/phoneCallStreet/note";
    _.note.splash = "amt";
}
function onStrumCreation(_){
    _.sprite = "stages/phoneCallStreet/note";
}

function onPostNoteCreation(_) {
    _.note.forceIsOnScreen = true;
	_.note.splash = "amt";
}

function onStartCountdown(){
    FlxTween.tween(stage.getSprite("introText"), {alpha: 1}, 1);
    camGame.followLerp *= 2;
}

function postUpdate(){
    p2cam.zoom = camHUD.zoom;

    switch(strumLines.members[curCameraTarget].characters[0].getAnimName()) {
		case "singLEFT": camFollow.x -= 10;
		case "singDOWN": camFollow.y += 10;
		case "singUP": camFollow.y -= 10;
		case "singRIGHT": camFollow.x += 10;
	
		case "singLEFT-alt": camFollow.x -= 10;
		case "singDOWN-alt": camFollow.y += 10;
		case "singUP-alt": camFollow.y -= 10;
		case "singRIGHT-alt": camFollow.x += 10;
	}
}

function beatHit(){
    switch(curBeat){
        case 12:
            FlxTween.tween(stage.getSprite("introText"), {alpha: 0.001}, 1);
        case 13:
            FlxTween.tween(ilovegaycam, {alpha: 0.001}, 1);
        case 30:
            camHUD.zoom += 0.5;
            FlxTween.tween(camHUD, {zoom: 1}, 1, {ease: FlxEase.expoOut});
            FlxTween.tween(camHUD, {alpha: 1}, 1);
        case 170:
            FlxTween.tween(p2cam, {x: 0}, 4, {ease: FlxEase.expoOut});
    }
}

function onDadHit(e) if(iconP1.animation.curAnim.curFrame != 1) health += -0.018; //:smiling_imp: :smiling_imp: :smiling_imp: 