import openfl.filters.ShaderFilter;
import openfl.Lib;
import flixel.addons.effects.FlxTrail;
import hxvlc.flixel.FlxVideoSprite;

var notehitcreateshit:Bool = true;
var dadtrail:FlxTrail;

var chroma = new CustomShader("null2/chroma");
function setChroma(chromeOffset){
    chroma.data.rOffset.value = [chromeOffset];
    chroma.data.gOffset.value = [0.0];
    chroma.data.bOffset.value = [chromeOffset * -1];
}

var bloom = new CustomShader("null2/bloom");
bloom.data.blurSize.value = [0.01];
bloom.data.intensity.value = [0.1];

var barrel = new CustomShader("null2/barrel");

var vignette = new CustomShader("null2/fuckywuckymask");
vignette.data.time.value = [250];
vignette.data.prob.value = [0.75];
vignette.data.glitchScale.value = [0.5];
vignette.data.maskMix.value = [true];
vignette.data.mask.input = Paths.image("stages/nullstage/vignette").bitmap;

var overlay = new CustomShader("null2/overlay");
var arrT:Array<Float> = [100.0,0.0,0.0];   //75.0,26.0,233.0 blue
var arrR:Array<Float> = [100.0,0.0,0.0];
var poses:Array<Float> = [0.5,0.5];
var amtt:Float = 0.0;  //075
var trans:Bool = false;
overlay.data.rT.value = [arrT[0]/255];
overlay.data.gT.value = [arrT[1]/255];
overlay.data.bT.value = [arrT[2]/255];
overlay.data.rR.value = [arrR[0]/255];
overlay.data.gR.value = [arrR[1]/255];
overlay.data.bR.value = [arrR[2]/255];
overlay.data.ypos.value = [poses[1]];
overlay.data.xpos.value = [poses[0]];
overlay.data.amt.value = [amtt];
overlay.data.trans.value = [trans];

var pixelate = new CustomShader("null2/pixelate");
pixelate.data.pixelSize.value = [1];

var pixelateAmount:Float = 1;
var hurtAmountBlack:Float = 0;

var nullGlitch = new CustomShader("null2/fuckywucky");	
nullGlitch.data.time.value = [250];
nullGlitch.data.prob.value = [0.1];
nullGlitch.data.glitchScale.value = [0.75];

var evilstatic = new CustomShader("null2/fuckassstatic");	

var videos = [];

function create(){
    enableCameraHacks = false;

    hurtBlack = new FlxSprite(0,0).makeSolid(1, 1, FlxColor.RED);
    hurtBlack.scale.set(1280 * 3, 720 * 3);
	hurtBlack.updateHitbox();
    hurtBlack.scrollFactor.set(0,0);
	hurtBlack.screenCenter();
    hurtBlack.alpha = 0;
    add(hurtBlack);

    add(helpme = new FlxVideoSprite(-50,175)).load(Assets.getPath(Paths.file("videos/HelpMe.mp4")));
    helpme.bitmap.onFormatSetup.add(function():Void
	{
	    if (helpme.bitmap != null && helpme.bitmap.bitmapData != null)
	    {
            helpme.scale.set(1.35,1.35);
            videos.push(helpme);
	    }
	});

    insert(0,numBg = new FlxVideoSprite(-50,175)).load(Assets.getPath(Paths.file('videos/NumberTunnel.mp4')), ['input-repeat=65535']);
    numBg.bitmap.onFormatSetup.add(function():Void
	{
	    if (numBg.bitmap != null && numBg.bitmap.bitmapData != null)
	    {
            numBg.scale.set(1.35,1.35);
            videos.push(numBg);
	    }
	});
    numBg.play();
    numBg.visible = false;
}

function onSubstateOpen() 
    for (v in videos) if (v != null && paused) v.pause();

function onSubstateClose()
    for (v in videos) if (v != null && paused) v.resume();

function onFocus() { onSubstateOpen(); }


function postCreate(){
    for (i => v in ['HelpMe','NumberTunnel','SecondTunnel']) vv = new FlxVideoSprite().load(Assets.getPath(Paths.video(v))); 

    dadtrail = new FlxTrail(dad, null, 8, 5, 0.4, 0.030);
    dad.alpha = 0.0001;
    strumLines.members[2].characters[0].alpha = 0.001;
    setChroma(0.002);

    camHUD.setFilters([new ShaderFilter(chroma),new ShaderFilter(bloom),new ShaderFilter(evilstatic),new ShaderFilter(overlay)]);
    camGame.setFilters([new ShaderFilter(barrel), new ShaderFilter(vignette),new ShaderFilter(chroma),new ShaderFilter(bloom),new ShaderFilter(nullGlitch),new ShaderFilter(evilstatic),new ShaderFilter(overlay),new ShaderFilter(pixelate)]);
}

function onPlayerMiss(){
    pixelateAmount += 2.0;
    hurtAmountBlack += 0.05;
}

function update(elapsed){
    nullGlitch.time = Conductor.songPosition*0.001;
    evilstatic.iTime = Conductor.songPosition*0.001;

    if (hurtAmountBlack > 0){
        hurtAmountBlack -= 0.2 * elapsed;
    } else if (hurtAmountBlack < 0){
        hurtAmountBlack = 0;
    }

    hurtBlack.alpha = hurtAmountBlack;

    pixelate.data.pixelSize.value = [Std.int(pixelateAmount)];

    if (pixelateAmount > 1){
        pixelateAmount -= 2 * elapsed;
    } else if (pixelateAmount < 1){
        pixelateAmount = 1;
    }
}

var shits:Array<String> = ['singLEFT','singDOWN','singUP','singRIGHT'];
function onPlayerHit(_){
    strumLines.members[2].characters[0].playAnim(shits[_.direction], true);
}

function onDadHit(){
    if (notehitcreateshit){
        var tra = new Character(dad.x + FlxG.random.float(-400,400), dad.y + FlxG.random.float(-400,400), dad.curCharacter, false);
	    insert(members.indexOf(dad), tra);
        tra.playAnim(dad.getAnimName(), true);
        tra.scale.set(FlxG.random.float(1,4),FlxG.random.float(1,4));
	    FlxTween.tween(tra, {alpha: 0.0001}, 0.5).onComplete = function() {
	    	tra.kill();
	    	remove(tra, true);
	    };
    }
}

function beatHit(){
    switch(curBeat){
        case 64:
            helpme.play();
            camHUD.alpha = 0.01;
        case 70:
            FlxTween.tween(camHUD,  {alpha: 1}, 0.25, {ease: FlxEase.sineInOut});
        case 72:
            numBg.visible = true;
            remove(helpme, true);
            notehitcreateshit = false;
            dad.alpha = 1;
            strumLines.members[2].characters[0].alpha = 1;
            strumLines.members[1].characters[0].alpha = 0.001;
            insert(members.indexOf(dad), dadtrail);

            FlxTween.tween(strumLines.members[2].characters[0],  {x: strumLines.members[2].characters[0].x + 400}, 4.0, {ease: FlxEase.sineInOut, type: FlxTween.PINGPONG});
            FlxTween.tween(strumLines.members[2].characters[0],  {y: strumLines.members[2].characters[0].y + 100}, 1.0, {ease: FlxEase.sineInOut, type: FlxTween.PINGPONG});
            FlxTween.tween(strumLines.members[2].characters[0].scale,  {x: 7, y: 7}, 3.0, {ease: FlxEase.sineInOut, type: FlxTween.PINGPONG});
    
            dadTweenX = FlxTween.tween(dad,  {x: dad.x - 200}, 4.0, {ease: FlxEase.sineInOut, type: FlxTween.PINGPONG});
            dadTweenY = FlxTween.tween(dad,  {y: dad.y - 50}, 1.0, {ease: FlxEase.sineInOut, type: FlxTween.PINGPONG});
    }
}