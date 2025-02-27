function create(){
    endo = new Character(112, 165, 'ourple/endohead', false);
	insert(members.indexOf(dad)-1, endo);
}

var uh:Array<String> = ['singLEFT','singDOWN','singUP','singRIGHT'];
function onNoteHit(_){
    if (_.noteType == "Special Sing"){
        _.cancelAnim();
        endo.playAnim(uh[_.direction],true);
    }
}