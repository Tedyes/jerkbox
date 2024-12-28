import openfl.display.Bitmap;
import openfl.display.BitmapData;

function create() {
	transitionTween.cancel();
	remove(blackSpr);
	remove(transitionSprite);
	transitionCamera.scroll.y = 0;
    add(ts = new FlxSprite().loadGraphic(BitmapData.fromImage(FlxG.stage.window.readPixels())));
	ts.cameras = [transitionCamera];
    ts.screenCenter();

	if(newState == null){
        ts.flipY = true;
        FlxTween.tween(ts, {alpha:0}, 0.7, {ease: FlxEase.quartOut});
	}else{
		FlxG.switchState(newState);
	}
}