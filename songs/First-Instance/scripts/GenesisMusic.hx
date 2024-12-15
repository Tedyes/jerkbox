function doShake(event){
    var curBpm = Conductor.bpm;
    var splited = event.split(' ');
    var lastBeat:Int = Std.parseInt(splited[0]);
    var intensity:Float = Std.parseFloat(splited[1]);


    var finalBeat = curBeat + lastBeat;//aqui el beat de termino
    var intensity = intensity;//aqui la intensidad 

    var seconds = 60/curBpm;
    var duration = (finalBeat - curBeat) * seconds;
    camGame.shake(intensity, duration);

    trace('doShake');
}