function postCreate(){
    for(c in [iconP1, iconP2, healthBar, healthBarBG]) remove(c,true);
}

function onCameraMove(e) {
    FlxG.camera.scroll.x += Math.sin(Conductor.songPosition);
    FlxG.camera.scroll.y += Math.sin(Conductor.songPosition);
    e.cancel(); 
}