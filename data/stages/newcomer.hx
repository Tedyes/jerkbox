function create(){
    FlxG.camera.bgColor = -1;
    trans.alpha = 0.001;
    finale.alpha = 0.001;
    v.cameras = [camHUD];
    v.scale.set(3,4);
    v.updateHitbox();
    v.alpha = 0.001;
}

function destroy(){
    FlxG.camera.bgColor = 0;
}