import openfl.display.BlendMode;
function create(){
    red.alpha = 0.75;
    redover.blend = BlendMode.MULTIPLY;
    redover.alpha = 0.25;
    for (i in [fire3,fire])
        i.blend = BlendMode.ADD;
}

function update(){
    michael.y = michael.y - 0.5 * Math.sin((Conductor.songPosition/1500) * (SONG.meta.bpm/120) *0.75);
    fire.alpha = 0.4+0.15*Math.sin((Conductor.songPosition/3000) * (SONG.meta.bpm/30) *1);
    fire3.alpha = 0.4+0.2*Math.sin((Conductor.songPosition/4000) * (SONG.meta.bpm/60) *1);
}