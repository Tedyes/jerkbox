import haxe.Json;

var p = PlayState.instance;
function postCreate(){
    head = new Character(0, 0, 'quitter/quitterHead', false);
    p.insert(p.members.indexOf(p.dad), head);
    p.remove(p.dad,true);
    p.cpuStrums.characters = [head];
}

function update(){
    updateHeadPos();
}

var offsets:Map<Dynamic> = Json.parse(Assets.getText(Paths.json('../data/quitterHeadOffsets')));
function updateHeadPos() {
    if(head == null) return;

    var curAnimName = p.boyfriend.animation.curAnim.name;
    var origin = Reflect.field(offsets, curAnimName).origin;
    var animOffsets = Reflect.field(offsets, curAnimName).offsets[p.boyfriend.animation.curAnim.curFrame];

    head.setPosition(p.boyfriend.x, p.boyfriend.y);
    head.origin.set(origin[0], origin[1]);
    head.x += animOffsets[0];
    head.y += animOffsets[1];

    head.angle = animOffsets[2];
}