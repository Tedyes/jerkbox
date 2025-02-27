import flixel.FlxObject;

public var cameraMovementStrength = 10;
public var cameraMovementEnabled = true;

public var smoothCamFollow:FlxObject = new FlxObject(0, 0, 2, 2);

function postCreate() {
    add(smoothCamFollow);
    FlxG.camera.target = smoothCamFollow;
    trace(cameraMovementEnabled);
}
function update(elapsed:Float) {
    smoothCamFollow.x = lerp(smoothCamFollow.x, camFollow.x, 0.25);
    smoothCamFollow.y = lerp(smoothCamFollow.y, camFollow.y, 0.25);
    camGame.angle = lerp(camGame.angle, 0, 0.25);
}

function postUpdate(elapsed:Float){
    if(!cameraMovementEnabled) return;

    for (i in strumLines.members[curCameraTarget].characters) {
        smoothCamFollow.x += i.getAnimName() == "singRIGHT" ? cameraMovementStrength : i.getAnimName() == "singLEFT" ? -cameraMovementStrength : 0;
        camGame.angle += i.getAnimName() == "singRIGHT" ? cameraMovementStrength/20 : i.getAnimName() == "singLEFT" ? -cameraMovementStrength/20 : 0;
        smoothCamFollow.y += i.getAnimName() == "singDOWN" ? cameraMovementStrength : i.getAnimName() == "singUP" ? -cameraMovementStrength : 0;
    }
}