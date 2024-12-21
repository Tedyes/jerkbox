import openfl.display.Bitmap;
import openfl.display.BitmapData;

function create() {
	transitionTween.cancel();
	remove(blackSpr);
    remove(transitionSprite);
    transitionCamera.scroll.y = 0;

    FlxG.cameras.add(ah = new HudCamera(), false);
    ah.bgColor = FlxColor.BLACK;

    if (newState == null){ 
        FlxTween.tween(ah, {alpha: 0.001}, 0.25);
    }else{
        ah.alpha = 0.001;
        FlxTween.tween(ah, {alpha: 1}, 0.25);
    }

	new FlxTimer().start(0.25, ()-> {finish();});
}