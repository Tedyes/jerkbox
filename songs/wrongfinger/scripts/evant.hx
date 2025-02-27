import flixel.FlxObject;

public var cameraMovementStrength = 1;
public var canMove:Bool = true;
public var smoothCamFollow:FlxObject = new FlxObject(0, 0, 2, 2);

importScript("data/scripts/bfdi/hud");
importScript("data/scripts/bfdi/doubles");

function create(){
    FlxG.cameras.add(introCam = new FlxCamera(), false);
    introCam.bgColor = camHUD.bgColor = 0xFF000000;

    gf.cameras = [introCam];
    gf.screenCenter();
}

function postCreate(){
    add(smoothCamFollow);
    FlxG.camera.target = smoothCamFollow;
}

function postUpdate(){
    camZooming = false;
    for (i in strumLines.members[curCameraTarget].characters) {
        if (canMove){
            smoothCamFollow.x += i.getAnimName() == "singRIGHT" ? cameraMovementStrength : i.getAnimName() == "singLEFT" ? -cameraMovementStrength : 0;
            smoothCamFollow.y += i.getAnimName() == "singDOWN" ? cameraMovementStrength : i.getAnimName() == "singUP" ? -cameraMovementStrength : 0;
        }
    }
}

function update(elapsed:Float) {
    smoothCamFollow.x = lerp(smoothCamFollow.x, camFollow.x, 0.1 + (2 * Math.pow(FlxMath.bound((smoothCamFollow.x - camFollow.x) / FlxG.width, 0, 1), 1)));
    smoothCamFollow.y = lerp(smoothCamFollow.y, camFollow.y, 0.1 + (2 * Math.pow(FlxMath.bound((smoothCamFollow.y - camFollow.y) / FlxG.height, 0, 1), 1)));
    FlxG.camera.zoom = lerp(FlxG.camera.zoom, defaultCamZoom, 0.035);
}

function cutend(){
    FlxTween.tween(introCam, {y: 1125}, 1,{ease: FlxEase.cubeInOut});
    FlxTween.tween(introCam, {angle: 45}, 3,{ease: FlxEase.sineOut});
}

function beatHit(){
    switch(curBeat){
        case 8:
            camHUD.bgColor = 0;
    }
}