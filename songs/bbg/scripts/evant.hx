function postCreate(){
    FlxG.camera.fade(0xFF000000, 0.001);
    add(flipaclip = new FlxSprite(25,25).loadGraphic(Paths.image('stages/sexy/Flipaclip')));	
	flipaclip.cameras = [camHUD];
    
    add(timetxt = new FlxText(-50, 25,FlxG.width, "", 0, true).setFormat("fonts/numb-bunny.otf", 50, 0xFF000000, "right"));
    timetxt.cameras = [camHUD];

    insert(members.indexOf(dad), sansanim = new Character(dad.x, dad.y, 'bbg/transformation', false));
    sansanim.visible = false;
    boyfriend.visible = false;

    for(i in [iconP1, iconP2, healthBar, healthBarBG]){
        remove(i,true);
    }
}

function onSongStart(){
    FlxG.camera.fade(0xFF000000, 4,true);
}

function update(){
    flipaclip.scale.set(lerp(flipaclip.scale.x,1,0.15),lerp(flipaclip.scale.y,1,0.15));

    if (Conductor.songPosition >= 0){
        timetxt.text = Std.int(Std.int((Conductor.songPosition) / 1000) / 60) + ":" + CoolUtil.addZeros(Std.string(Std.int((Conductor.songPosition) / 1000) % 60), 2);
	}
}

function beatHit(){
    flipaclip.scale.set(1.15,1.16);
}

function sansyap(the){
    dad.visible = false;
    sansanim.visible = true;
    sansanim.playAnim(the);
}

function sansunyap(){
    sansanim.visible = false;
}

function drak(){
    FlxTween.tween(stage.getSprite("g"), {y: -25}, 15);
}

function gf(){
    boyfriend.visible = true;
    FlxTween.tween(boyfriend, {y: 0}, 0.5);
}