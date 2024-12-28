import openfl.filters.ShaderFilter;

public var camUHHHH:FlxCamera;
var ntsc = new CustomShader('ntsc');

function create() {
    if (stage == null || stage.stageXML == null) return;
    if (stage.stageXML.exists("funkscopsong") && stage.stageXML.get("funkscopsong") == "true"){
        var barcam:FlxCamera;
        FlxG.game._filters = [new ShaderFilter(ntsc)];
        doIconBop = false;
        if (PlayState.SONG.meta.displayName == "Quitter"){
            introSounds = ["oddpetscopintro", "oddpetscopintro", "oddpetscopintro", "oddpetscopintro2"];
        }else{
            introSounds = ["petscopintro", "petscopintro", "petscopintro", "petscopintro2"];
        }

        barcam = new FlxCamera();
        barcam.bgColor = 0;
        FlxG.cameras.remove(camHUD, false);
        FlxG.cameras.add(barcam, false);
        FlxG.cameras.add(camHUD, false);
        bar = new FlxSprite().loadGraphic(Paths.image("stages/funkscop/BLACKBARS"));
        bar.cameras = [barcam];
        insert(0,bar);
    }
}

function onPostStartCountdown(){
    if (stage == null || stage.stageXML == null) return;
    if (stage.stageXML.exists("funkscopsong") && stage.stageXML.get("funkscopsong") == "true"){
        for(i in [scoreTxt, accuracyTxt, missesTxt]){
            i.font = "fonts/PetscopWide.ttf";
            i.scale.set(1.5,1.5);
        }
        camHUD.alpha = 0.0001;
        camUHHHH = new FlxCamera();
        camUHHHH.bgColor = 0xFF000000;
        FlxG.cameras.add(camUHHHH, false);
        introSprites = ["Countdown/3", "Countdown/2", "Countdown/1", "Countdown/GO"];
        FlxTween.tween(camUHHHH, {zoom: 1.1}, Conductor.crochet / 250);
    }
}

function onPostCountdown(event) {
    if (stage == null || stage.stageXML == null) return;
    if (stage.stageXML.exists("funkscopsong") && stage.stageXML.get("funkscopsong") == "true"){
        if (event.swagCounter != 4){
            event.spriteTween.cancel();
            event.sprite.alpha = 0.001;

            var count = new FlxSprite().loadGraphic(Paths.image(introSprites[event.swagCounter]));
            count.scale.set(6, 6);
            count.updateHitbox();
	    	count.screenCenter();
            count.antialiasing = false;
            count.cameras = [camUHHHH];
            add(count);
            FlxTween.tween(count, {alpha: 1}, Conductor.crochet / 1000, {onComplete: function() {count.alpha = 0.001;}});
            if (event.swagCounter == 3 && PlayState.SONG.meta.displayName != "Quitter"){
               FlxTween.tween(count, {angle: 360}, Conductor.crochet / 1000, {ease: FlxEase.cubeOut});
            }
        }else{
            songText = new FunkinText(0, 0, 0, PlayState.SONG.meta.displayName, 36, true);
            songText.font = "fonts/PetscopWide.ttf";
            songText.cameras = [camUHHHH];
            songText.screenCenter();
            songText.y += 250;
            songText.alpha = 0.0001;
            add(songText);

            if (PlayState.SONG.meta.displayName != "Quitter"){
                camUHHHH.flash(FlxColor.WHITE, 0.5);
            }
            camUHHHH.bgColor = 0;

            FlxTween.tween(songText, {alpha: 1}, 1.5, {startDelay: 1,ease: FlxEase.cubeOut,
                onComplete: function() {
                    FlxTween.tween(songText, {alpha: 0.0001}, 1.5, {startDelay: 0.25,ease: FlxEase.cubeOut});
                    FlxTween.tween(camHUD, {alpha: 1}, 1.5, {startDelay: 0.25,ease: FlxEase.cubeOut});
                }});
        }
    }
}

function onNoteCreation(e){
    if (stage == null || stage.stageXML == null) return;
    if (stage.stageXML.exists("funkscopsong") && stage.stageXML.get("funkscopsong") == "true")
        e.noteSprite = "stages/funkscop/NOTE_assets";
}
function onStrumCreation(e){
    if (stage == null || stage.stageXML == null) return;
    if (stage.stageXML.exists("funkscopsong") && stage.stageXML.get("funkscopsong") == "true")
        e.sprite = "stages/funkscop/NOTE_assets";
}

function destroy(){
    FlxG.game._filters = [];
}