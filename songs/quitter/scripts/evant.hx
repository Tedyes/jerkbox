function create(){
    c = new CustomShader('adjustColor');//gonnachangeshader
    FlxG.game.addShader(c);
}
function beatHit(){
    switch(curBeat){
        case 160:
            c.contrast = 0;
        case 224:
            c.contrast = 0;
    }
}
function destroy(){
    FlxG.game.removeShader(c);
}