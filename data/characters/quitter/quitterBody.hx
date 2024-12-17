import haxe.Json;

function postCreate(){
    head = new Character(0, 0, 'quitter/quitterHead', false);
    PlayState.instance.insert(PlayState.instance.members.indexOf(PlayState.instance.dad), head);
    PlayState.instance.remove(PlayState.instance.dad,true);
    PlayState.instance.cpuStrums.characters = [head];
}

function update(){
    updateHeadPos();
}

function updateHeadPos() {
    if(head == null) return;

    var offsets:Map<Dynamic> = Json.parse(Assets.getText(Paths.json('../data/quitterHeadOffsets')));
    var curAnimName = PlayState.instance.boyfriend.animation.curAnim.name;
    var origin = Reflect.getProperty(offsets, curAnimName).origin;
    var animOffsets = Reflect.getProperty(offsets, curAnimName).offsets[PlayState.instance.boyfriend.animation.curAnim.curFrame];

    head.setPosition(PlayState.instance.boyfriend.x, PlayState.instance.boyfriend.y);
    head.origin.set(origin[0], origin[1]);
    head.x += animOffsets[0];
    head.y += animOffsets[1];

    head.angle = animOffsets[2];
}