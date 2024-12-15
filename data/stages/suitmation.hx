import flixel.addons.display.FlxBackdrop;

var ntsc = new CustomShader('ntsc');
function postCreate(){
    window.frameRate = 48;
    FlxG.game.addShader(ntsc);
    camGame.bgColor = 0;

    var clouds = new FlxBackdrop(Paths.image('stages/suitmation/analog_godzilla_cloud2'), 0x01, 0,0);
	clouds.setPosition(0,275);
    clouds.scale.set(0.155,0.155);
	clouds.velocity.set(5, 0);
	clouds.antialiasing=true;
	insert(1, clouds);

    var bgg = new FlxBackdrop(Paths.image('stages/suitmation/analog_godzilla_bg'), 0x01, 0,0);
    bgg.setPosition(0,25);
    bgg.scale.set(0.2,0.2);
	bgg.velocity.set(2.5, 0);
	bgg.antialiasing=true;
	insert(0, bgg);
}

function onCameraMove(e) {
    camFollow.setPosition(750,570.5);
    FlxG.camera.snapToTarget();
    e.cancel();
}

function destroy(){
    FlxG.game.removeShader(ntsc);
    window.frameRate = 240;
}

function onPostStartCountdown(){
    strumsCam = new HudCamera();
    strumsCam.bgColor = 0;
    FlxG.cameras.add(strumsCam, false);
    strumsCam.downscroll = true;
    
    bar = new FlxSprite(0,0).loadGraphic(Paths.image("firstbar"));
    add(bar);
    bar.cameras = [strumsCam];

    playerStrums.cameras = [strumsCam];
    for (i in 0...playerStrums.members.length) playerStrums.members[i].scrollFactor.set(0,0);
    camHUD.alpha = 0.001;

    camUHHHH = new FlxCamera();
    camUHHHH.bgColor = 0xFF000000;
    FlxG.cameras.add(camUHHHH, false);

    introSounds = [null, null, null, null];
    introSprites = [null,"stages/suitmation/ready", "stages/suitmation/set", "stages/suitmation/go"];
    FlxG.camera.shake(0.00025,999999999999);
    strumsCam.shake(0.0006,999999999999);
    camUHHHH.shake(0.0006,999999999999);
}

function onPostCountdown(event) {
    if (event.swagCounter != 4){
        if (event.sprite != null){
            event.spriteTween.cancel();
            event.sprite.alpha = 0.001;

            var count = new FlxSprite().loadGraphic(Paths.image(introSprites[event.swagCounter]));
            count.scale.set(0.4, 0.4);
            count.updateHitbox();
		    count.screenCenter();
            count.antialiasing = false;
            count.cameras = [camUHHHH];
            add(count);
            FlxTween.tween(count, {alpha: 1}, Conductor.crochet / 1000, {onComplete: function() {count.alpha = 0.001;}});
        }
    }else{
        songText = new FunkinText(0, 0, 0, "Instance #1.mp4", 36, true);
        songText.font = "fonts/arial.ttf";
        songText.cameras = [camUHHHH];
        songText.screenCenter();
        songText.y += 250;
        songText.alpha = 0.0001;
        add(songText);

        camUHHHH.bgColor = 0;

        FlxTween.tween(songText, {alpha: 1}, 1.5, {startDelay: 1,ease: FlxEase.cubeOut,
            onComplete: function() {
                FlxTween.tween(songText, {alpha: 0.0001}, 1.5, {startDelay: 1,ease: FlxEase.cubeOut});
            }});
    }
}

function onNoteCreation(event) {
	event.cancel();
	var note = event.note;
	
	if (!event.cancel) {
		switch (event.noteType) {
			default:
				note.frames = Paths.getFrames('notes firstinstance');
			switch (event.strumID % 4 ) {
				case 0:
					note.animation.addByPrefix('scroll', 'purple0');
					note.animation.addByPrefix('hold', 'purple hold piece');
					note.animation.addByPrefix('holdend', 'purple end hold');
				case 1:
					note.animation.addByPrefix('scroll', 'blue0');
					note.animation.addByPrefix('hold', 'blue hold piece');
					note.animation.addByPrefix('holdend', 'blue hold end');
				case 2:
					note.animation.addByPrefix('scroll', 'green0');
					note.animation.addByPrefix('hold', 'green hold piece');
					note.animation.addByPrefix('holdend', 'green hold end');
				case 3:
					note.animation.addByPrefix('scroll', 'red0');
					note.animation.addByPrefix('hold', 'red hold piece');
					note.animation.addByPrefix('holdend', 'red hold end');
			}
			note.scale.set(0.3, 0.3);
			note.updateHitbox();
		}
	}
}

function onStrumCreation(event) {
	event.cancel();
	var strum = event.strum;
	if (!event.cancel) {
		strum.frames = Paths.getFrames('notes firstinstance');
		strum.animation.addByPrefix('green', 'arrowUP');
		strum.animation.addByPrefix('blue', 'arrowDOWN');
		strum.animation.addByPrefix('purple', 'arrowLEFT');
		strum.animation.addByPrefix('red', 'arrowRIGHT');
		strum.antialiasing = true;
		strum.scale.set(0.3,0.3);
		
		switch (event.strumID % 4) {
			case 0:
				strum.animation.addByPrefix("static", 'arrowLEFT0');
				strum.animation.addByPrefix("pressed", 'left press', 24, false);
				strum.animation.addByPrefix("confirm", 'left confirm', 24, false);
			case 1:
				strum.animation.addByPrefix("static", 'arrowDOWN0');
				strum.animation.addByPrefix("pressed", 'down press', 24, false);
				strum.animation.addByPrefix("confirm", 'down confirm', 24, false);
			case 2:
				strum.animation.addByPrefix("static", 'arrowUP0');
				strum.animation.addByPrefix("pressed", 'up press', 24, false);
				strum.animation.addByPrefix("confirm", 'up confirm', 24, false);
			case 3:
				strum.animation.addByPrefix("static", 'arrowRIGHT0');
				strum.animation.addByPrefix("pressed", 'right press', 24, false);
				strum.animation.addByPrefix("confirm", 'right confirm', 24, false);
		}	
		strum.updateHitbox();
	}
}