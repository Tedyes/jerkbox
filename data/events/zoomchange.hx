function onEvent(_){
    if (_.event.name == 'zoomchange') {
        defaultCamZoom += Std.parseFloat(_.event.params[0]);
        if (_.event.params[1] == true){
            FlxG.camera.zoom = defaultCamZoom;
        }
    }
}