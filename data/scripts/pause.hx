function postCreate() {
    add(logo = new FlxSprite(0,0).loadGraphic(Paths.image( (PlayState.SONG.meta.logo != null) ? 'logos/' + PlayState.SONG.meta.logo : 'logos/null')));
    logo.setPosition(FlxG.width - logo.width - 15,FlxG.height - logo.height - 10);
	logo.updateHitbox();
    logo.alpha = 0;
    FlxTween.tween(logo, {alpha: 0.5, y: logo.y - 5}, 0.4, {ease: FlxEase.quartInOut, startDelay: 0.3 * 2});
	add(logo);
}