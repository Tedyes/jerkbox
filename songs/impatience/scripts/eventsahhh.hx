var forcemove = true;

function postCreate(){
    camZoomingInterval = 9999999;
    defaultCamZoom = 0.7;
    FlxTween.tween(FlxG.camera, {zoom: 0.7}, 0.001);
    camFollow.setPosition(boyfriend.getGraphicMidpoint().x,boyfriend.getGraphicMidpoint().y);

    benhiihii = new Character(boyfriend.x-125, boyfriend.y+225, 'benjamin', true);
    benhiihii.visible = false;
    insert(members.indexOf(boyfriend), benhiihii);

    dad.visible = false;
    for (h in stage.stageSprites){
        h.visible = false;
    }
}

function onCameraMove(e) {
	if (forcemove){
        e.cancel();
    }
	if (!forcemove){
	switch(curCameraTarget) {
		case 0:
			defaultCamZoom = 1.1;
		case 1:
			defaultCamZoom = 0.8;
	}
	}
}

function stepHit(){
    switch(curStep){
        case 504:
            FlxTween.tween(FlxG.camera, {zoom: 0.3}, 1.5,{ease: FlxEase.expoIn});
        case 508:
            FlxG.camera.fade(0xFFff6600, 0.5);
        case 512:
            FlxG.camera.fade(0xFFff6600, 0.0001,true);
            FlxG.camera.flash(0xFFffffff, 0.5);

            dad.visible = true;
            boyfriend.visible = false;
            benhiihii.visible = true;
            playerStrums.characters = [benhiihii];
            for (h in stage.stageSprites){
                h.visible = true;
            }
            forcemove = false;
            camZoomingInterval = 4;
        case 767:
            FlxG.camera.flash(0xFFffffff, 0.5);
            camZoomingInterval = 2;
        case 1008:
            camZoomingInterval = 9999999;
        case 1024:
            camZoomingInterval = 1;
    }
}

function postUpdate(elapsed){
    if (curBeat >= 192 && curBeat <= 384 || curBeat >= 516 && curBeat <= 652){
        FlxG.camera.angle = 1.25 * Math.sin((Conductor.songPosition) / 1000 * 1.7);
    }else{
        FlxG.camera.angle = 0;
    }

	if (!forcemove){
		switch(strumLines.members[curCameraTarget].characters[0].getAnimName()) {
			case "singLEFT": camFollow.x -= 25;
			case "singDOWN": camFollow.y += 25;
			case "singUP": camFollow.y -= 25;
			case "singRIGHT": camFollow.x += 25;
	
			case "singLEFT-alt": camFollow.x -= 35;
			case "singDOWN-alt": camFollow.y += 35;
			case "singUP-alt": camFollow.y -= 35;
			case "singRIGHT-alt": camFollow.x += 35;
		}
	}
}