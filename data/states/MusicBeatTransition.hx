function create() {
	transitionTween.cancel();
	remove(blackSpr);
    remove(transitionSprite);
    transitionCamera.scroll.y = 0;

    finish();
}