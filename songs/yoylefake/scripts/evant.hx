import funkin.backend.utils.ShaderResizeFix;
import openfl.system.Capabilities;
import openfl.filters.ShaderFilter;

var windowtwn:FlxTween;
var combohud:HudCamera;
var other:FlxCamera;
var forcemove = false;
var rainShader = new CustomShader('yoylefake/rain');
var drunk = new CustomShader('yoylefake/drunk');
var time:Float = 0;

function onStartCountdown(event) {
    event.cancel(true); 
	startSong();
	startedCountdown = true;
	if (startTimer == null)
		startTimer = new FlxTimer();
}

function create(){
    for(i in ['h', 'fire3','fire', 'michael', 'red', 'table', 'p1', 'p2', 'redover'])
        stage.getSprite(i).visible = false;
}

function postCreate(){
    FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 0.001);
    FlxG.cameras.add(realhud = new HudCamera(0, 0, 1280, 720), false);
    realhud.bgColor = 0;
    realhud.alpha = 0.001;
    camHUD.bgColor = 0xFF000000;
    realhud.downscroll = Options.downscroll;

    FlxG.cameras.add(other = new FlxCamera(), false);
    other.bgColor = 0;

    add(text = new FlxText(0, 325, FlxG.width, "BFDI 26: YOYLEFAKE", 0, true).setFormat("fonts/Shag-Lounge.otf", 75, FlxColor.WHITE, "center"));
    text.cameras = [other];
    text.alpha = 0.001;

    strumLines.members[0].cameras = [realhud];
    strumLines.members[1].cameras = [realhud];

    for(c in [iconP1, iconP2, healthBar, healthBarBG, scoreTxt, accuracyTxt, missesTxt]){
        c.cameras = [realhud];
        c.x += 175;
        c.alpha = 0.0001;
    }

    rainShader.data.uScreenResolution.value = [FlxG.width, FlxG.height];
    rainShader.uTime = 0;
    rainShader.uScale = FlxG.height/500;
    rainShader.uIntensity = 0.2;

    stage.getSprite("h").shader = drunk;
}

function onNoteHit(_){
    _.ratingPrefix = "stages/yoylefake/";
}

function onNoteCreation(_){
    _.noteSprite = "stages/yoylefake/NOTE_assets";
}
function onStrumCreation(_){
    _.sprite = "stages/yoylefake/NOTE_assets";
}

function onPostNoteCreation(_) {
	_.note.splash = "bfdi";
}

function postUpdate(elapsed){
    realhud.zoom = camHUD.zoom;
    time += elapsed;
    rainShader.data.uCameraBounds.value = [camGame.scroll.x + camGame.viewMarginX, camGame.scroll.y + camGame.viewMarginY, camGame.scroll.x + camGame.viewMarginX + camGame.width, camGame.scroll.y + camGame.viewMarginY + camGame.height];
    rainShader.uTime = time;
    rainShader.uIntensity = 0.25;
    if (windowtwn != null){
        ShaderResizeFix.doResizeFix = true;
        ShaderResizeFix.fixSpritesShadersSizes();
        window.x = Capabilities.screenResolutionX/2 - window.width/2;
        window.y = Capabilities.screenResolutionY/2 - window.height/2;
        FlxG.scaleMode.width = FlxG.width = FlxG.camera.width = camHUD.width = FlxG.initialWidth = window.width;
        FlxG.scaleMode.height = FlxG.height = FlxG.camera.height = camHUD.height = FlxG.initialHeight = window.height;
    }

	if (!forcemove){
		switch(strumLines.members[curCameraTarget].characters[0].getAnimName()) {
			case "singLEFT": camFollow.x -= 25;
			case "singDOWN": camFollow.y += 25;
			case "singUP": camFollow.y -= 25;
			case "singRIGHT": camFollow.x += 25;
	
			case "singLEFT-alt": camFollow.x -= 25;
			case "singDOWN-alt": camFollow.y += 25;
			case "singUP-alt": camFollow.y -= 25;
			case "singRIGHT-alt": camFollow.x += 25;
		}
	}
}

function stepHit(){
    drunk.iTime = time;
}

function beatHit(){
    switch(curBeat){
        case 4:
            FlxTween.tween(text, {alpha: 1}, 1.5);
        case 26:
            FlxTween.tween(text, {y: 325 + 750}, 1.25,{ease: FlxEase.cubeInOut});
            FlxTween.tween(text, {angle: 45}, 3,{ease: FlxEase.sineOut});
        case 28:
            FlxTween.tween(realhud, {alpha: 1}, 1.5);
            FlxTween.tween(text, {alpha: 0}, 1.5);
        case 32:
            camHUD.bgColor = 0;
        case 96:
            for(i in ['h', 'fire3','fire', 'michael', 'red', 'table', 'redover']){
                stage.getSprite(i).visible = true;
            }
            for(i in ['bg3', 'bg4']){
                stage.getSprite(i).visible = false;
            }
            windowtwn = FlxTween.tween(window, {width: 1280, height: 720}, 0.3 * 4, {ease: FlxEase.expoOut,onComplete: function() {camGame.setFilters([new ShaderFilter(rainShader)]); windowtwn = null;}});
            strumLines.members[0].cameras = [camGame];
            for(c in [iconP1, iconP2, healthBar, healthBarBG, scoreTxt, accuracyTxt, missesTxt]){
                c.alpha = 1;
            }
            for (i in 0...strumLines.members[0].members.length)
            {
                FlxTween.tween(strumLines.members[1].members[i], {x: strumLines.members[1].members[i].x + 225}, 0.3 * 4, {ease: FlxEase.expoOut});
                strumLines.members[0].members[i].scrollFactor.set(1,1);
                strumLines.members[0].members[i].x = 750 + 200*i;
                strumLines.members[0].members[i].y = 1000;
            }
        case 320:
            windowtwn = FlxTween.tween(window, {width: 960, height: 720}, 0.3 * 4, {ease: FlxEase.expoOut,onComplete: function() {windowtwn = null;}});
            for (i in 0...strumLines.members[1].members.length)
            {
                FlxTween.tween(strumLines.members[1].members[i], {x: strumLines.members[1].members[i].x - 225}, 0.3 * 4, {ease: FlxEase.expoOut});
            }
            for(c in [iconP1, iconP2, healthBar, healthBarBG, scoreTxt, accuracyTxt, missesTxt]){
                c.alpha = 0.001;
            }
        case 384:
            windowtwn = FlxTween.tween(window, {width: 1280, height: 720}, 0.3 * 10, {ease: FlxEase.quadInOut,onComplete: function() {windowtwn = null;}});
            for (i in 0...strumLines.members[1].members.length)
            {
                FlxTween.tween(strumLines.members[1].members[i], {x: strumLines.members[1].members[i].x + 225}, 0.3 * 10, {ease: FlxEase.quadInOut});
            }
    }
}