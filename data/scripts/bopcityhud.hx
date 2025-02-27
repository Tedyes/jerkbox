function onNoteCreation(_){
    _.noteSprite = "stages/bopcity/dick";
}
function onStrumCreation(_){
    _.sprite = "stages/bopcity/dick";
}

function onPostNoteCreation(_) {
    _.note.forceIsOnScreen = true;
	_.note.splash = "bopcity";
}

function postCreate(){
    for (i in [missesTxt,scoreTxt,accuracyTxt]){
        i.font = "fonts/papyrus.ttf";
        i.size = 25;
    }
    scoreTxt.x += 25;
    accuracyTxt.x -= 100;

    FlxG.cameras.add(camNotes = new HudCamera(), false);
	camNotes.bgColor = 0;
	if (downscroll) {
		camNotes.downscroll = true;
	}

    for (i in [missesTxt,scoreTxt,accuracyTxt,iconP1,iconP2,healthBar,healthBarBG]){
        i.cameras = [camNotes];
        i.x += 200;
        i.scrollFactor.set(1,1);
    }

    for(a in strumLines){
        a.cameras = [camNotes];

        for (i in 0...a.members.length){
            a.members[i].scrollFactor.set(1,1);
        }
    }
    for (i in 0...playerStrums.members.length){
        playerStrums.members[i].x += 350;
        playerStrums.members[i].y -= 100;
    }
    for (i in 0...cpuStrums.members.length){
        cpuStrums.members[i].x += 50;
        cpuStrums.members[i].y -= 100;
    }
}

function postUpdate(){
    iconP1.scale.set(1,1);
    iconP1.x = iconP1.y = 0;
    iconP2.angularVelocity += 1;
    missesTxt.scale.set(Math.random()*5,Math.random()*5);
    scoreTxt.scale.set(Math.random()*5,Math.random()*5);
    accuracyTxt.scale.set(Math.random()*5,Math.random()*5);
    healthBarBG.y += Math.cos(Conductor.songPosition/1000)*10;
    for (i in 0...playerStrums.members.length){
        playerStrums.members[i].x += Math.sin(Math.random()*10000);
        playerStrums.members[i].y += Math.cos(Math.random()*10000);
    }

    for (i in 0...cpuStrums.members.length){
        cpuStrums.members[i].x += Math.cos(Conductor.songPosition/1000)*(i+1);
        cpuStrums.members[i].y += Math.sin(Conductor.songPosition/1000)*(i+1);
    }

    camNotes.zoom = FlxG.camera.zoom;
    camNotes.scroll.x = FlxG.camera.scroll.x;
    camNotes.scroll.y = FlxG.camera.scroll.y;

    for (i in strumLines.members[curCameraTarget].characters) {
        healthBar.x += i.getAnimName() == "singRIGHT" ? 10 : i.getAnimName() == "singLEFT" ? -10 : 0;
    }
}


function onPlayerHit(e) {
    if(e.note.isSustainNote)
        return;

    e.showRating = false;

    var rating:FlxSprite = comboGroup.recycleLoop(FlxSprite);
    CoolUtil.resetSprite(rating, comboGroup.x, comboGroup.y);
    CoolUtil.loadAnimatedGraphic(rating, Paths.image("stages/bopcity/" + e.rating));
    rating.acceleration.y = 550;
    rating.velocity.y -= FlxG.random.int(-140*2, 175*2);
    rating.velocity.x -= FlxG.random.float(-250, 250);
    rating.angularVelocity = FlxG.random.float(-100, 100);
    if (e != null) {
        rating.scale.set(e.ratingScale+0.75, e.ratingScale-0.5);
        rating.antialiasing = e.ratingAntialiasing;
    }
    rating.updateHitbox();
    rating.x -= rating.width / 2;
    rating.y -= rating.height / 2;
    
    FlxTween.tween(rating, {'scale.x': e.ratingScale, 'scale.y': e.ratingScale}, 0.5, {ease: FlxEase.backOut});
    FlxTween.tween(rating, {alpha: 0}, FlxG.random.float(0.75, 10), {
        startDelay: Conductor.crochet * 0.0004,
        onComplete: function(tween:FlxTween) {
            rating.kill();
        }
    });

    var separatedScore:String = CoolUtil.addZeros(Std.string(combo + 1), 3);
    for(i in 0...separatedScore.length) {
        var numScore:FlxSprite = comboGroup.recycleLoop(FlxSprite);
        CoolUtil.loadAnimatedGraphic(numScore, Paths.image("stages/bopcity/" + 'num' + separatedScore.charAt(separatedScore.length - i - 1)));
        CoolUtil.resetSprite(numScore, comboGroup.x - ((43 * i) - 10), comboGroup.y + 50);
        if (e != null) {
            numScore.antialiasing = e.numAntialiasing;
            numScore.scale.set(e.numScale+0.75, e.numScale-0.5);
        }
        numScore.updateHitbox();

        numScore.acceleration.y = FlxG.random.int(200, 300);
        numScore.velocity.y -= FlxG.random.int(-140*2, 160*2);
        numScore.velocity.x = FlxG.random.float(-250, 250);
        numScore.angularVelocity = FlxG.random.float(-100, 100);

        FlxTween.tween(numScore, {'scale.x': e.numScale, 'scale.y': e.numScale}, 0.5, {ease: FlxEase.backOut});
        FlxTween.tween(numScore, {alpha: 0}, FlxG.random.float(0.75, 10), {
            onComplete: function(tween:FlxTween) {
                numScore.kill();
            },
            startDelay: Conductor.crochet * 0.0009
        });
    }
}