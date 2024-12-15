import openfl.display.BlendMode;
function create(){
    camZooming = true;
    lamplight.blend = BlendMode.ADD;
}


function zoomswitch(bool){
    camZooming = bool;
}