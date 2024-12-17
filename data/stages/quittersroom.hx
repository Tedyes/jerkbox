function onCameraMove(e) {
    camFollow.setPosition(200,300);
    FlxG.camera.snapToTarget();
    e.cancel();
}