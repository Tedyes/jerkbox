var bgcam:FlxCamera;

function create(){
    bgcam = new FlxCamera();
    bgcam.bgColor = 0xFF000000;
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(bgcam, false);
    FlxG.cameras.add(camHUD, false);
    camZoomingInterval = 9999999;

    add(bg = new FlxSprite().loadGraphic(Paths.image("stages/miku/LOVE_GROOVE_FINAL_BACKGROUND")));
    bg.cameras = [bgcam];
    bg.screenCenter();
    camHUD.alpha = 0;
    FlxG.camera.alpha = 0;
}

function onSongStart(){
    for(c in [iconP1, iconP2, healthBar, healthBarBG, scoreTxt, accuracyTxt, missesTxt]){
        remove(c);
    }
    camHUD.alpha = 1;
    bg.alpha = 0;
    FlxTween.tween(bg, {alpha: 0.25}, 1, {ease: FlxEase.quadOut});
}

function onPostCountdown(_)
    if (_.sprite != null)
        _.sprite.cameras = [bgcam];

function onNoteHit(_)
    _.showSplash = false;

function onNoteCreation(_)
    _.noteSprite = "stages/miku/notitg_NOTE_assets";

function onStrumCreation(_)
    _.sprite = "stages/miku/notitg_NOTE_assets";
