function postCreate(){
    camHUD.zoom = 0.9;
    camZoomingInterval = 9999999; defaultHudZoom = 0.9;
    healthBarBG.loadGraphic(Paths.image("stages/iron/healthBarlung")); healthBarBG.updateHitbox(); healthBarBG.screenCenter(); healthBarBG.y += 292.5;
    icony = iconP2.y;
}

function postUpdate(){
    iconP2.x += FlxG.random.float(-1,1)*health;
    iconP2.y = icony + FlxG.random.float(-1,1)*health;
}

function onDadHit(event){
    event.deleteNote = false;
    event.strumGlowCancelled = true;
}