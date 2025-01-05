import haxe.io.Path;
import sys.FileSystem;
import hxvlc.flixel.FlxVideoSprite;

function create(){
    //lung
    var imags = FileSystem.readDirectory('./mods/jerkbox/images/characters/iron');
    var itemp = [];
    for (i in imags) itemp.push(Path.withoutExtension(i));
    imags = itemp;
	trace(imags);
    for (i => v in imags) graphicCache.cache(Paths.image("characters/iron/" + v));

    var imags = FileSystem.readDirectory('./mods/jerkbox/images/stages/iron');
    var itemp = [];
    for (i in imags) itemp.push(Path.withoutExtension(i));
    imags = itemp;
	trace(imags);
    for (i => v in imags) graphicCache.cache(Paths.image("stages/iron/" + v));

    //yoylefake
    var imags = FileSystem.readDirectory('./mods/jerkbox/images/characters/yoylefake');
    var itemp = [];
    for (i in imags) itemp.push(Path.withoutExtension(i));
    imags = itemp;
	trace(imags);
    for (i => v in imags) graphicCache.cache(Paths.image("characters/yoylefake/" + v));

    var imags = FileSystem.readDirectory('./mods/jerkbox/images/stages/yoylefake');
    var itemp = [];
    for (i in imags) itemp.push(Path.withoutExtension(i));
    imags = itemp;
	trace(imags);
    for (i => v in imags) graphicCache.cache(Paths.image("stages/yoylefake/" + v));

    //icons
    var imags = FileSystem.readDirectory('./mods/jerkbox/images/icons');
    var itemp = [];
    for (i in imags) itemp.push(Path.withoutExtension(i));
    imags = itemp;
	trace(imags);
    for (i => v in imags) graphicCache.cache(Paths.image("icons/" + v));

    //videos
    var vids = FileSystem.readDirectory('./mods/jerkbox/videos');
    var temp = [];
    for (i in vids) temp.push(Path.withoutExtension(i));
    vids = temp;
	trace(vids);
    for (i => v in vids) vv = new FlxVideoSprite().load(Assets.getPath(Paths.video(v))); 

    new FlxTimer().start(1.5, function(tmr:FlxTimer){
        FlxG.switchState(new FreeplayState());
    });
}