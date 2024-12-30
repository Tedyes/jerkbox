var combohud:FlxCamera;
var numArray:FlxTypedGroup<FlxSprite>;

function postCreate(){
    FlxG.cameras.add(combohud = new FlxCamera(), false);
    combohud.bgColor = 0;

    add(numArray = new FlxTypedGroup());
    numArray.cameras = [combohud];

    add(rating = new FlxSprite(0,FlxG.height * 0.5 - 60));
    rating.cameras = [combohud];
    rating.visible = false;

    strumLines.members[0].cpu = false;
}

function update(){
    rating.scale.x = rating.scale.y = lerp(rating.scale.x,0.8,0.25);
}

function onPlayerHit(NoteHitEvent) {
    num(NoteHitEvent);
}

function num(note){
    numArray.forEach(function(spr:FlxSprite){
		spr.destroy();
	});
    var seperatedScore = []; 
	if (combo >= 1000) { seperatedScore.push(Math.floor(combo / 1000) % 10);}
    if (combo >= 100){seperatedScore.push(Math.floor(combo / 100) % 10);}
    if (combo >= 10){seperatedScore.push(Math.floor(combo / 10) % 10);}
	seperatedScore.push(combo % 10);
	var i = 0;
    for (n in seperatedScore){
		numArray.add(numScore = new FlxSprite());
        numScore.loadGraphic(Paths.image('stages/miku/notitg/num' + n));
        numScore.x = FlxG.width * 0.75 + (i * 40) - (31 - numScore.frameWidth * 0.5) - (20 * seperatedScore.length) + 20;
        numScore.y = FlxG.height * 0.5 + 20;
        numScore.scale.set(0.8, 0.8);
        i++;
	}
    rating.loadGraphic(Paths.image('stages/miku/notitg/' + note.rating));
    rating.x = FlxG.width * 0.75 - rating.frameWidth * 0.5;
    rating.scale.set(0.9, 0.9);
    rating.visible = true;
}