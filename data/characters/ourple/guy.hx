var self = this;
var flippedIdle:Bool = false;
var flipped:Bool = false;
var ourplex = null;

function beatHit(){
    if (PlayState.instance.healthBar.percent < 80){
        flipped = (flipped == true) ? false : true;
        PlayState.instance.iconP2.flipX = flipped;
    }
    if (self.animation.curAnim.name != 'idle') return;
    flippedIdle = (flippedIdle == true) ? false : true;
    self.flipX = flippedIdle;
    self.x = (flippedIdle == true) ? ourplex-200 : ourplex;
    self.playAnim("idle");
    self.forceIsOnScreen = true;
}

function stepHit(curStep){
    if (PlayState.instance.healthBar.percent > 80 && curStep % 2 == 0){
        flipped = (flipped == true) ? false : true;
        PlayState.instance.iconP2.flipX = flipped;
    }
}

function update(){
    PlayState.instance.iconP2.angle = (PlayState.instance.healthBar.percent > 80) ? FlxG.random.float(-5, 5) : 0;

    if (ourplex == null && PlayState.instance.dad.x != null) ourplex = PlayState.instance.dad.x;
    if (self.animation.curAnim.name != 'idle' || PlayState.instance.curCameraTarget == 0){
        self.flipX = false;
        self.x = ourplex;
    }
}