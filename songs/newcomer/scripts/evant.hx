import flixel.ui.FlxBarFillDirection;
import flixel.ui.FlxBar;
import funkin.backend.utils.FlxInterpolateColor;
var camCenter = true;
var force = false;
var crazy = false;
var grayLerp:FlxInterpolateColor;
var thebgcolor = -1;

function onNoteCreation(_){
    _.noteSprite = "stages/newcomer/newcomernotes";
}
function onStrumCreation(_){
    _.sprite = "stages/newcomer/newcomernotes";
}

function onPostNoteCreation(_) {
    _.note.forceIsOnScreen = true;
	_.note.splash = "newcomer";
}

function postCreate(){
    remove(strumLines.members[2].characters[0]);
    strumLines.members[2].characters[0].alpha = 0.001;
    grayLerp = new FlxInterpolateColor(-1);
    FlxG.camera.fade(0xFF000000, 0.001);

    insert(members.indexOf(healthBarBG), healbar = new FlxBar(healthBarBG.x,healthBarBG.y-20, FlxBarFillDirection.RIGHT_TO_LEFT, 602, 49, PlayState.instance, "health", 0, maxHealth));
	healbar.createImageBar(Paths.image("stages/newcomer/zalgo"),Paths.image("stages/newcomer/ayumu")); 
    healbar.cameras = [camHUD];

    for(i in [healthBar, healthBarBG]){
        i.alpha = 0.001;
    }
}

function onStartCountdown(){
    FlxTween.tween(FlxG.camera, {zoom: 0.25}, 0.001);
    FlxTween.tween(FlxG.camera, {zoom: 0.75}, 1, {ease: FlxEase.quadInOut});
    defaultCamZoom = 0.75;
    FlxG.camera.fade(0xFF000000, 1,true);
}

function onCameraMove(e){
    if (force || camCenter) e.cancel();
    if (camCenter) camFollow.setPosition(550,350);
}

function onDadHit(e)
    if(crazy){ 
        if(iconP1.animation.curAnim.curFrame != 1) health += -0.03; 
        FlxG.camera.shake(0.0075,0.075); 
        camHUD.shake(0.0025,0.075);
    }

function postUpdate(){
    grayLerp.fpsLerpTo(thebgcolor, 0.2);
	FlxG.camera.bgColor = grayLerp.color;

    iconP2.x = healbar.x-100;
    iconP1.x = healbar.width+100;
}

function beatHit(){
    if (curBeat >= 204 && curBeat <= 211 || curBeat >= 220 && curBeat <= 228 || curBeat >= 236 && curBeat <= 243 || curBeat >= 252 && curBeat <= 268) {
		grayLerp.color = FlxColor.GRAY;
	}
    switch(curBeat){
        case 4:
            camCenter = false;
        case 68:
            thebgcolor = FlxColor.GRAY;
            force = true;
            camFollow.setPosition(175,515);
            FlxTween.tween(camHUD, {alpha: 0}, 0.5, {ease: FlxEase.sineOut});
        case 76:
            thebgcolor = -1;
            crazy = camCenter = true;
            force = false;
            FlxTween.tween(camHUD, {alpha: 1}, 0.4, {ease: FlxEase.sineOut});
        case 124:
            insert(members.indexOf(dad)+1,strumLines.members[2].characters[0]);
            FlxTween.tween(strumLines.members[2].characters[0], {alpha: 0.5}, 0.4, {ease: FlxEase.sineOut});
        case 140:
            crazy = camCenter = false;
            remove(strumLines.members[2].characters[0]);
            FlxTween.tween(stage.getSprite("v"), {alpha: 0.7}, 2, {ease: FlxEase.sineOut});
        case 188:
            FlxTween.tween(FlxG.camera, {zoom: 1.5}, 3.5);
        case 200:
            FlxTween.tween(stage.getSprite("v"), {alpha: 0}, 1.2, {ease: FlxEase.sineOut});
        case 204:
            crazy = camCenter = true;
        case 268:
            FlxTween.tween(FlxG.camera, {zoom: 1}, 1.5, {ease: FlxEase.elasticIn});
        case 271:
            stage.getSprite("trans").alpha = 1;
            stage.getSprite("trans").playAnim('go');
        case 274:
            for(i in [iconP1, iconP2, healbar, scoreTxt, accuracyTxt, missesTxt]){
                FlxTween.tween(i, {y: i.y + 150}, 0.5, {ease: FlxEase.circIn});
            }
        case 276:
            thebgcolor = FlxColor.BLACK;
            stage.getSprite("finale").alpha = 1;
        case 340:
            camHUD.bgColor = FlxColor.BLACK;
        case 341:
            camHUD.bgColor = 0;
            camGameZoomLerp = 0.1;
            maxCamZoom = 99.99;
        case 404:
            camGameZoomLerp = 0.05;
        case 408:
            FlxG.camera.fade(FlxColor.BLACK, 0.8);
    }
}
