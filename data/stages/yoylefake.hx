import openfl.display.BlendMode;
function create(){
    red.alpha = 0.75;
    redover.alpha = 0.25;

    for (i in [fire3,fire,redover]){
        i.blend = BlendMode.ADD;
    }
    for (i in [center,center2,center3]){
        drop(i);
    }
}

function update(){
    michael.y += -0.5 * Math.sin((Conductor.songPosition/1500) * (SONG.meta.bpm/120) *0.75);
    fire.alpha = 0.45 + (-0.075 * Math.sin((Conductor.songPosition/300) * (SONG.meta.bpm/30) *1));
    fire3.alpha = 0.45 + (-0.075 * Math.sin((Conductor.songPosition/400) * (SONG.meta.bpm/60) *1));
}

function drop(fucker){
    fucker.x = FlxG.random.int(250,2000);
    fucker.y = -500;
    fucker.angle = 0;
    var t = FlxG.random.int(2,5);
    FlxTween.tween(fucker, {y: FlxG.random.int(2500,3000),}, t,{ease: FlxEase.quadIn,onComplete: function() {drop(fucker);}});
    FlxTween.tween(fucker, {angle: FlxG.random.int(360,1080)}, t + 0.5,{ease: FlxEase.cubeInOut});
}