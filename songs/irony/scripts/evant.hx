import flixel.FlxObject;
import Shadow;

public var cameraMovementStrength = 2;
public var canMove:Bool = true;
public var smoothCamFollow:FlxObject = new FlxObject(0, 0, 2, 2);
final blur = new CustomShader('blur');

importScript("data/scripts/bopcityhud");

function postCreate(){
    add(smoothCamFollow);
    FlxG.camera.target = smoothCamFollow;

    blur.directions = 16;
    blur.quality = 4;
    blur.size = 8;

    for (c in [boyfriend, dad]) {
        s = new Shadow(c);
        s.alpha = 0.65;
        s.shader = blur;
        s.matrixExposed = true;

        switch(c) {
            case boyfriend:
                var lol = new FlxMatrix(1, 0, -1.0, 0.6, 140, -980);
                s.transformMatrix = lol;
                s.flipY = false;

            case dad: 
                s.flipY = false;
                s.transformMatrix = new FlxMatrix(1, 0, 1, 0.6, -355, -2025);
        }
    }
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
    FlxG.camera.zoom = lerp(FlxG.camera.zoom, defaultCamZoom, 0.035);
}