import flixel.FlxObject;

public var cameraMovementStrength = 1;
public var canMove:Bool = true;
public var smoothCamFollow:FlxObject = new FlxObject(0, 0, 2, 2);
var forcemove = false;

function onCameraMove(_) 
    if (forcemove){ 
        canMove = false;
        _.cancel();
    }else{
        canMove = true;
    }

function postCreate(){
    dadcampos = dad.getCameraPosition();
    add(smoothCamFollow);
    FlxG.camera.target = smoothCamFollow;
}

function postUpdate(){
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
}

function beatHit(){
    switch(curBeat){
        case 368:
            forcemove = true;
            camFollow.setPosition(200, 225);
            smoothCamFollow.setPosition(200, 225);
            FlxG.camera.snapToTarget();
        case 384:
            FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom - 1}, 1.5, {ease: FlxEase.cubeInOut});
            defaultCamZoom -= 1;
            FlxTween.tween(camFollow, {x: dadcampos.x ,y: dadcampos.y}, 1.5, {ease: FlxEase.cubeInOut});
        case 400:
            forcemove = false;
    }
}