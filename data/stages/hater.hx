import openfl.display.BlendMode;

var multiLight = 0.25;

function onStartCountdown(){
    camZooming = true;
    FlxTween.tween(FlxG.camera, {zoom: 1}, 0.001);
    defaultCamZoom = 1;
    camHUD.fade(0xFF000000, 1,true);

    FlxG.camera.angle = -5;

    castlelight.blend = lavalight.blend = BlendMode.ADD;
    castlelight.alpha = 0.15;
}

function update(){
    castlelight.alpha = lerp(castlelight.alpha,0.15,0.1);
    lava.y += Math.sin(Conductor.songPosition/1000)/3;
    FlxG.camera.angle += Math.sin(Conductor.songPosition/1000)/50;
    lavalight.alpha = lerp(lavalight.alpha,0.4 + (0.5 * Math.cos(Conductor.songPosition/250)),0.1);
}

function stepHit(){
    var particles;
    add(particles = new FlxSprite(FlxG.random.float(400,3250),1750).loadGraphic(Paths.image('stages/hater/particles_ihy')));
    FlxTween.tween(particles, {y: -100}, FlxG.random.float(0.75, 5), {onComplete: function(tween:FlxTween) {particles.kill();}});
}

function beatHit(){
    FlxG.camera.zoom += 0.1*multiLight;
    castlelight.alpha = 1*multiLight;
    lavalight.alpha = 1*multiLight;
}

function changeMulti(_){
    multiLight = _;
}

function onCameraMove(){
  switch (curCameraTarget) {
    case 0:
        defaultCamZoom = 0.6;
    case 1:
        defaultCamZoom = 0.9;
  }
}