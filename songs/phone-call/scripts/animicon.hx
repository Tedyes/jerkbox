import flixel.math.FlxRect;
static var animiconP1:FlxSprite;
static var animiconP2:FlxSprite;
var singAnims = ["singLEFT", "singDOWN", "singUP", "singRIGHT"];
var singAnimsalt = ["singLEFT-alt", "singDOWN-alt", "singUP-alt", "singRIGHT-alt"];
var healthSHIT = {lerphealth: 50};

function postCreate() {
    iconP1.visible = iconP2.visible = false;
    for(i in [healthBar, healthBarBG]){
        i.alpha = 0.001;
    }

    var leftColor:Int = dad != null && dad.iconColor != null && Options.colorHealthBar ? dad.iconColor : (opponentMode ? 0xFF66FF33 : 0xFFFF0000);
	var rightColor:Int = boyfriend != null && boyfriend.iconColor != null && Options.colorHealthBar ? boyfriend.iconColor : (opponentMode ? 0xFFFF0000 : 0xFF66FF33);
    insert(members.indexOf(healthBarBG), healthBarrealbg = new FlxSprite(healthBarBG.x-75,healthBarBG.y-17.5, Paths.image("stages/phoneCallStreet/HEALTHBAR")));
    healthBarrealbg.camera = camHUD;
    insert(members.indexOf(healthBar), rightHealth = new FlxSprite(healthBarBG.x-50,healthBarBG.y-10, Paths.image("stages/phoneCallStreet/WHITEBAR")));
    rightHealth.camera = camHUD;
    rightHealth.color = rightColor;
	insert(members.indexOf(healthBar), leftHealth = new FlxSprite(healthBarBG.x-50,healthBarBG.y-10, Paths.image("stages/phoneCallStreet/WHITEBAR")));
    leftHealth.camera = camHUD;
    leftHealth.color = leftColor;
    leftHealth.clipRect = new FlxRect(leftHealth.frameWidth*0.75, 0, leftHealth.frameWidth*0.5, leftHealth.frameHeight);

    animiconP1 = new FlxSprite();
    animiconP1.frames = Paths.getSparrowAtlas("icons/phonecall/icon-tadano");
    animiconP1.animation.addByPrefix("basic", "basic0", 24, false);
    animiconP1.animation.addByPrefix("win2basic", "win-to-basic", 24, false);
    animiconP1.animation.addByPrefix("predeath2lose", "predeath-to-lose", 24, false);
    animiconP1.animation.addByPrefix("lose2predeath", "lose-to-predeath", 24, false);
    animiconP1.animation.addByPrefix("lose2basic", "lose-to-basic", 24, false);
    animiconP1.animation.addByPrefix("basic2win", "basic-to-win", 24, false);
    animiconP1.animation.addByPrefix("basic2lose", "basic-to-lose", 24, false);
    animiconP1.animation.play("basic");
    animiconP1.cameras = [camHUD]; animiconP1.scrollFactor.set(); animiconP1.updateHitbox(); animiconP1.antialiasing = false;
    insert(members.indexOf(iconP1),animiconP1);

    animiconP2 = new FlxSprite();
    animiconP2.frames = Paths.getSparrowAtlas("icons/phonecall/icon-komi");
    animiconP2.animation.addByPrefix("basic", "basic0", 24, false);
    animiconP2.animation.addByPrefix("lose", "lose0", 24, false);
    animiconP2.animation.addByPrefix("singLEFT", "left", 24, false);
    animiconP2.animation.addByPrefix("singDOWN", "down", 24, false);
    animiconP2.animation.addByPrefix("singUP", "up", 24, false);
    animiconP2.animation.addByPrefix("singRIGHT", "right", 24, false);
    animiconP2.animation.addByPrefix("singLEFT-alt", "alt left", 24, false);
    animiconP2.animation.addByPrefix("singDOWN-alt", "alt down", 24, false);
    animiconP2.animation.addByPrefix("singUP-alt", "alt up", 24, false);
    animiconP2.animation.addByPrefix("singRIGHT-alt", "alt right", 24, false);
    animiconP2.animation.addByPrefix("lose2basic", "lose-to-basic", 24, false);
    animiconP2.animation.addByPrefix("basic2lose", "basic-to-lose", 24, false);
    animiconP2.animation.finishCallback = (f)->
	{
		switch(f){
			case "singLEFT"|"singDOWN"|"singUP"|"singRIGHT"|"singLEFT-alt"|"singDOWN-alt"|"singUP-alt"|"singRIGHT-alt":
				animiconP2.animation.play((healthBar.percent > 80) ? 'lose':'basic');
		}
	}
    animiconP2.animation.play("basic");
    animiconP2.cameras = [camHUD]; animiconP2.scrollFactor.set(); animiconP2.updateHitbox(); animiconP2.antialiasing = false;
    insert(members.indexOf(iconP2),animiconP2);

    icony = iconP1.y;
}

function onDadHit(e)
    if (curBeat <= 164)
        animiconP2.animation.play((healthBar.percent > 80) ? singAnimsalt[e.direction]:singAnims[e.direction],true);

var P1winanim:Bool = true;
var P1loseanim:Bool = true;
var P1deathanim:Bool = true;
var P2loseanim:Bool = true;
function postUpdate() {
    leftHealth.clipRect = new FlxRect(leftHealth.frameWidth * (health / maxHealth), 0, leftHealth.frameWidth * (1 - health / maxHealth), leftHealth.frameHeight);
    healthSHIT.lerphealth = lerp(healthSHIT.lerphealth, healthBar.percent, 0.1);
    var iconOffset = 26;
	var center = leftHealth.x + leftHealth.width * healthSHIT.lerphealth/100;
    iconP1.x = center - (iconP1.width - iconOffset);
	iconP2.x = center - iconOffset;
    if (downscroll){
        iconP1.y = iconP2.y = icony - (iconP1.height / 2) + 100 - (Math.cos((health - 1) * 2) * 15);
    }else{
        iconP1.y = iconP2.y = icony - (iconP1.height / 2) + 50 + (Math.cos((health - 1) * 2) * 15);
    }
	animiconP1.y = iconP1.y+30;
	animiconP1.x = iconP1.x;
    animiconP1.scale.set(iconP1.scale.x,iconP1.scale.y);
	animiconP1.updateHitbox();

    animiconP2.y = iconP2.y+20;
	animiconP2.x = iconP2.x;
    animiconP2.scale.set(iconP2.scale.x,iconP2.scale.y);
	animiconP2.updateHitbox();

    if (P1winanim && healthSHIT.lerphealth > 80){
        animiconP1.animation.play('basic2win');
        P1winanim = false;
    }else if (healthSHIT.lerphealth < 80 && !P1winanim){
        animiconP1.animation.play('win2basic');
        P1winanim = true;
    }
    if (P1loseanim && healthSHIT.lerphealth < 40 && healthSHIT.lerphealth > 20){
        animiconP1.animation.play('basic2lose');
        P1loseanim = false;
    }else if (healthSHIT.lerphealth > 40 && !P1loseanim){
        animiconP1.animation.play('lose2basic');
        P1loseanim = true;
    }
    if (P1deathanim && healthSHIT.lerphealth < 20){
        animiconP1.animation.play('lose2predeath');
        P1deathanim = false;
    }else if (healthSHIT.lerphealth > 20 && !P1deathanim){
        animiconP1.animation.play('predeath2lose');
        P1deathanim = true;
    }
    if (P2loseanim && healthSHIT.lerphealth > 80){
        animiconP2.animation.play('basic2lose');
        P2loseanim = false;
    }else if (healthSHIT.lerphealth < 80 && !P2loseanim){
        animiconP2.animation.play('lose2basic');
        P2loseanim = true;
    }
}