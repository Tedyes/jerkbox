var cameraMovementStrength = 50;
var canMove:Bool = true;

function postUpdate(){
    for (i in strumLines.members[curCameraTarget].characters) {
        if (canMove){
            camFollow.x += i.getAnimName() == "singRIGHT" ? cameraMovementStrength : i.getAnimName() == "singLEFT" ? -cameraMovementStrength : 0;
            camFollow.y += i.getAnimName() == "singDOWN" ? cameraMovementStrength : i.getAnimName() == "singUP" ? -cameraMovementStrength : 0;
        }
    }
}