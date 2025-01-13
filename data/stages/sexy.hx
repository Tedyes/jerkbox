function create(){
    FlxG.camera.bgColor = -1;
}

function onCameraMove(e) {
    camFollow.setPosition(-15,25);
    FlxG.camera.snapToTarget();
    e.cancel();
}

function destroy(){
    FlxG.camera.bgColor = 0;
}