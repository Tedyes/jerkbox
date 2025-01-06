import funkin.backend.utils.ShaderResizeFix;
import openfl.system.Capabilities;
import openfl.filters.ShaderFilter;
import hxvlc.flixel.FlxVideoSprite;
import haxe.io.Path;
import sys.FileSystem;

var windowtwn:FlxTween;
var vidcam:FlxCamera;
var combohud:HudCamera;
var other:FlxCamera;
var forcemove = false;
var shakey = false;
var rainShader = new CustomShader('yoylefake/rain');
var shew = new CustomShader('yoylefake/shew');
var lava = new CustomShader('yoylefake/lava');
var time:Float = 0;
var videos = [];

function create(){
    var vids = FileSystem.readDirectory('./mods/jerkbox/videos');
    var temp = [];
    for (i in vids) temp.push(Path.withoutExtension(i));
    vids = temp;
    for (i => v in vids) vv = new FlxVideoSprite().load(Assets.getPath(Paths.video(v))); 

    for(i in ['h', 'fire3','fire', 'michael', 'red', 'table', 'p1', 'p2', 'redover', 'center', 'center2', 'center3'])
        stage.getSprite(i).visible = false;
}

function postCreate(){
    FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 0.001);

    FlxG.cameras.add(vidcam = new FlxCamera(0, 0, 1280, 720), false);
    vidcam.bgColor = 0;

    FlxG.cameras.add(realhud = new HudCamera(0, 0, 1280, 720), false);
    realhud.bgColor = 0;
    realhud.alpha = 0.001;
    camHUD.bgColor = 0xFF000000;
    realhud.downscroll = Options.downscroll;

    FlxG.cameras.add(other = new FlxCamera(), false);
    other.bgColor = 0;

    FlxG.cameras.add(ythud = new HudCamera(0, 0, 1280, 720), false);
    ythud.bgColor = 0;
    ythud.downscroll = true;

    add(bars = new FlxSprite(0,0).loadGraphic(Paths.image('stages/yoylefake/bars')));
    bars.cameras = [camHUD];
    bars.visible = false;

    add(text = new FlxText(0, 325, FlxG.width, "BFDI 26: YOYLEFAKE", 0, true).setFormat("fonts/Shag-Lounge.otf", 75, FlxColor.WHITE, "center"));
    text.cameras = [other];
    text.alpha = 0.001;

    add(timetxt = new FlxText(30, 30, FlxG.width, "", 0, true).setFormat("fonts/Shag-Lounge.otf", 25, 0xFF777777, "left"));
    timetxt.cameras = [ythud];

    add(brothebar = new FlxSprite(0,0).makeSolid(1, 10, 0xFFFF0000));
	brothebar.cameras = [ythud];

    add(brothedot = new FlxSprite(-10,-5).loadGraphic(Paths.image('stages/yoylefake/reddot')));
    brothedot.scale.set(0.5,0.5);
    brothedot.updateHitbox();
	brothedot.cameras = [ythud];

    insert(0,db = new FlxSprite(1000,125).loadGraphic(Paths.image('stages/yoylefake/dirtybubblerender')));
    db.cameras = [realhud];
    db.scale.set(1.7,1.7);
    db.alpha = 0.001;

    insert(1,ezzy = new FlxSprite());
    ezzy.cameras = [realhud];
    ezzy.frames = Paths.getSparrowAtlas("stages/yoylefake/ezzylogo");
    ezzy.animation.addByPrefix('idle', 'ezzy', 24, true);
    ezzy.animation.play("idle");
    ezzy.scale.set(0.75,0.75);
    ezzy.screenCenter();
    ezzy.alpha = 0.001;

    for(i in [timetxt,brothebar,brothedot]){
        i.alpha = 0.0001;
    }
    FlxTween.tween(brothebar.scale, {x: 1280*2}, Std.int((inst.length) / 1000));
    FlxTween.tween(brothedot, {x: 1280}, Std.int((inst.length) / 1000));

    strumLines.members[0].cameras = [realhud];
    strumLines.members[1].cameras = [realhud];

    for(c in [iconP1, iconP2, healthBar, healthBarBG, scoreTxt, accuracyTxt, missesTxt]){
        c.cameras = [realhud];
        c.x += 175;
        c.alpha = 0.0001;

        c.color = 0xFFffc8c8;
    }

    rainShader.data.uScreenResolution.value = [FlxG.width, FlxG.height];
    rainShader.uTime = 0;
    rainShader.uScale = FlxG.height/500;
    rainShader.uIntensity = 0.2;

    stage.getSprite("h").shader = shew;

    add(sing = new FlxVideoSprite()).load(Paths.video("yoylefake"));
    sing.bitmap.onFormatSetup.add(function():Void
	{
	    if (sing.bitmap != null && sing.bitmap.bitmapData != null)
	    {
	        sing.cameras = [vidcam];
            sing.scale.set(0.675,0.675);
            sing.updateHitbox();
            videos.push(sing);
	    }
	});

    add(ending = new FlxVideoSprite()).load(Paths.video("yoylefakeEnd"));
    ending.bitmap.onFormatSetup.add(function():Void
	{
	    if (ending.bitmap != null && ending.bitmap.bitmapData != null)
	    {
	        ending.cameras = [vidcam];
            ending.scale.set(0.67,0.67);
            ending.updateHitbox();
            videos.push(ending);
	    }
	});
}

function onSubstateOpen() 
    for (v in videos) if (v != null && paused) v.pause();

function onSubstateClose()
    for (v in videos) if (v != null && paused) v.resume();

function onFocus() { onSubstateOpen(); }

function onStartCountdown(event) {
    event.cancel(true); 
	startSong();
	startedCountdown = true;
	if (startTimer == null)
		startTimer = new FlxTimer();
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
    _.note.forceIsOnScreen = true;
	_.note.splash = "bfdi";
}

var elaptime:Float = 0.0;
function postUpdate(elapsed){
    realhud.zoom = camHUD.zoom;
    time += elapsed;
    elaptime += elapsed;
    rainShader.data.uCameraBounds.value = [camGame.scroll.x, camGame.scroll.y, camGame.scroll.x + camGame.viewMarginX + camGame.width, camGame.scroll.y + camGame.viewMarginY + camGame.height];
    rainShader.uTime = time;
    lava.iTime = time;
    rainShader.uIntensity = 0.25;

    if (elaptime >= 0.35){
        elaptime = 0.0;
        shew.iTime = FlxG.random.float(-10.0,10.0);
    }

    if (windowtwn != null){
        ShaderResizeFix.doResizeFix = true;
        ShaderResizeFix.fixSpritesShadersSizes();
        window.x = Capabilities.screenResolutionX/2 - window.width/2;
        window.y = Capabilities.screenResolutionY/2 - window.height/2;
        FlxG.scaleMode.width = FlxG.width = FlxG.camera.width = camHUD.width = FlxG.initialWidth = window.width;
        FlxG.scaleMode.height = FlxG.height = FlxG.camera.height = camHUD.height = FlxG.initialHeight = window.height;
    }

    if (Conductor.songPosition >= 0){
        timetxt.text = Std.int(Std.int((Conductor.songPosition) / 1000) / 60) + ":" + CoolUtil.addZeros(Std.string(Std.int((Conductor.songPosition) / 1000) % 60), 2) + "/" + Std.int(Std.int((inst.length) / 1000) / 60) + ":" + CoolUtil.addZeros(Std.string(Std.int((inst.length) / 1000) % 60), 2);
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

function onCameraMove(e) {
    if (forcemove)
        e.cancel();
}

function onDadHit(e){
    if (shakey){
        FlxG.camera.shake(0.0075,0.075);
        realhud.shake(0.0025,0.075);
        for (i in 0...strumLines.members[0].members.length){
            var nangle = strumLines.members[0].members[i].angle;
            if (nangle > (nangle-3) && nangle < (nangle+3)){
                strumLines.members[0].members[i].angle += Math.random(-2,2);
            }else if (nangle < (nangle-3)){
                strumLines.members[0].members[i].angle += Math.random(1,2);
            }else if (nangle > (nangle+3)){
                strumLines.members[0].members[i].angle += Math.random(-2,1);
            }
            strumLines.members[0].members[i].noteAngle = 0;
        }
    }
}

function beatHit(){
    switch(curBeat){
        case 4:
            FlxTween.tween(text, {alpha: 1}, 1.5);
        case 16:
            FlxTween.color(text, 2, FlxColor.WHITE, FlxColor.RED);
        case 26:
            FlxTween.tween(text, {y: 325 + 750}, 1.25,{ease: FlxEase.cubeInOut});
            FlxTween.tween(text, {angle: 45}, 3,{ease: FlxEase.sineOut});
        case 28:
            FlxTween.tween(realhud, {alpha: 1}, 1.5);
            FlxTween.tween(text, {alpha: 0}, 1.5);
        case 32:
            camHUD.bgColor = 0;
            FlxTween.tween(ezzy, {alpha: 1}, 1.25,{ease: FlxEase.quadOut});
            FlxTween.tween(db, {alpha: 1}, 2,{ease: FlxEase.quadOut});
            FlxTween.tween(db, {x: 500}, 1.75,{ease: FlxEase.circOut});
        case 42:
            FlxTween.tween(ezzy, {alpha: 0}, 1.25,{ease: FlxEase.quadOut});
            FlxTween.tween(db, {alpha: 0}, 2,{ease: FlxEase.quadOut});
            FlxTween.tween(db, {x: 1000}, 2,{ease: FlxEase.quadIn});
        case 95:
            for(i in [dad, boyfriend]){
                FlxTween.color(i, 0.5, FlxColor.WHITE, FlxColor.RED,{ease: FlxEase.quadOut});
            }
            for(i in ['bg3', 'bg4']){
                FlxTween.color(stage.getSprite(i), 0.5, FlxColor.WHITE, FlxColor.BLACK,{ease: FlxEase.quadOut});
            }
        case 96:
            bars.visible = true;
            for(i in ['h', 'fire3','fire', 'michael', 'red', 'table', 'redover', 'center', 'center2', 'center3']){
                stage.getSprite(i).visible = true;
            }
            for(i in ['bg3', 'bg4']){
                stage.getSprite(i).visible = false;
            }
            windowtwn = FlxTween.tween(window, {width: 1280, height: 720}, 0.3 * 4, {ease: FlxEase.expoOut,onComplete: function() {camGame.setFilters([new ShaderFilter(rainShader)]); windowtwn = null;}});
            strumLines.members[0].cameras = [camGame];
            for(c in [iconP1, iconP2, healthBar, healthBarBG, scoreTxt, accuracyTxt, missesTxt,timetxt,brothebar,brothedot]){
                c.alpha = 1;
            }
            for (i in 0...strumLines.members[0].members.length)
            {
                FlxTween.tween(strumLines.members[1].members[i], {x: strumLines.members[1].members[i].x + 225}, 0.3 * 4, {ease: FlxEase.expoOut});
                strumLines.members[0].members[i].scrollFactor.set(1,1);
                strumLines.members[0].members[i].x = 750 + 200*i;
                strumLines.members[0].members[i].y = 1000;
                strumLines.members[0].members[i].color = strumLines.members[1].members[i].color = 0xFFffc8c8;
            }
            shakey = true;
        case 320:
            windowtwn = FlxTween.tween(window, {width: 960, height: 720}, 0.3 * 4, {ease: FlxEase.expoOut,onComplete: function() {windowtwn = null;}});
            for (i in 0...strumLines.members[1].members.length)
            {
                FlxTween.tween(strumLines.members[1].members[i], {x: strumLines.members[1].members[i].x - 225}, 0.3 * 4, {ease: FlxEase.expoOut});
            }

            bars.visible = false;
            for(i in ['h', 'fire3','fire', 'michael', 'red', 'table', 'redover', 'center', 'center2', 'center3']){
                stage.getSprite(i).visible = false;
            }
            camGame.setFilters([]);
            shakey = false;
            for(i in ['bg3', 'bg4']){
                stage.getSprite(i).visible = true;
                stage.getSprite(i).color = 0xFF4D2B2E;
            }
            for(c in [iconP1, iconP2, healthBar, healthBarBG, scoreTxt, accuracyTxt, missesTxt,timetxt,brothebar,brothedot]){
                c.alpha = 0.001;
            }
            strumLines.members[0].visible = false;
        case 352:
            stage.getSprite('bg3').visible = false;
            stage.getSprite("h").visible = true;
        case 384:
            camHUD.bgColor = 0xFF000000;
            stage.getSprite('bg4').visible = false;
            forcemove = true;
            camFollow.setPosition(1935,1425);
            windowtwn = FlxTween.tween(window, {width: 1280, height: 720}, 0.3 * 10, {ease: FlxEase.quadInOut,onComplete: function() {windowtwn = null;}});
            for (i in 0...strumLines.members[1].members.length)
            {
                FlxTween.tween(strumLines.members[1].members[i], {x: strumLines.members[1].members[i].x + 225}, 0.3 * 10, {ease: FlxEase.quadInOut});
            }
        case 400:
            bars.visible = true;
            for(c in [iconP1, iconP2, healthBar, healthBarBG, scoreTxt, accuracyTxt, missesTxt,timetxt,brothebar,brothedot]){
                c.alpha = 1;
            }
            for(i in ['center', 'center2', 'center3']){
                stage.getSprite(i).visible = true;
            }
            camHUD.bgColor = 0;
            stage.getSprite("h").shader = lava;
        case 461:
            FlxTween.tween(dad, {alpha: 0}, 0.25, {startDelay: 0.25});
        case 464:
            stage.getSprite("red").visible = true;
            FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom - 0.5}, 1.5, {ease: FlxEase.circOut});
            FlxTween.tween(camFollow, {x: 1935 - 175}, 1.5, {ease: FlxEase.cubeInOut});
            FlxTween.tween(camFollow, {y: 1425 - 50}, 2.5, {ease: FlxEase.cubeInOut});
            defaultCamZoom -= 0.5;
        case 560:
            FlxTween.tween(FlxG.camera, {zoom: 1.35}, 12);
            FlxTween.tween(camFollow, {x: 1935,y: 1425 + 50}, 12.5, {ease: FlxEase.cubeInOut});
        case 592:
            camHUD.bgColor = 0xFF000000;
            FlxTween.tween(realhud, {alpha: 0.001}, 0.75);
        case 599:
            sing.play();
            sing.alpha = 0.001;
			FlxTween.tween(sing,{alpha: 1},0.75);
        case 629:
            FlxTween.tween(realhud, {alpha: 1}, 0.25);
        case 632:
            remove(sing, true);
            shakey = true;
            forcemove = false;
            camHUD.bgColor = 0;
            stage.getSprite("red").visible = false;
            strumLines.members[0].visible = true;
            for(i in ['p1', 'p2','fire3','fire']){
                stage.getSprite(i).visible = true;
            }

            FlxTween.tween(FlxG.camera, {zoom: 0.575}, 3, {ease: FlxEase.circOut});
            defaultCamZoom = 0.575;
        case 727:
            FlxTween.tween(FlxG.camera, {zoom: 1.5}, 0.5);
            defaultCamZoom = 1.5;
            forcemove = true;
            FlxTween.tween(camFollow, {x: dad.x + 100}, 0.35, {ease: FlxEase.cubeInOut});
            FlxTween.tween(camFollow, {y: dad.y + 200}, 0.5, {ease: FlxEase.cubeInOut});
            FlxTween.tween(realhud, {alpha: 0.001}, 0.5);
        case 728:
            ythud.visible = false;
            ending.play();
    }
}