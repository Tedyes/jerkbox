function onNoteCreation(_){
    _.noteSprite = "stages/bopcity/dick";
}
function onStrumCreation(_){
    _.sprite = "stages/bopcity/dick";
}

function onNoteHit(_){
    _.ratingPrefix = "stages/bopcity/";
}

function onPostNoteCreation(_) {
    _.note.forceIsOnScreen = true;
	_.note.splash = "bopcity";
}

function postCreate(){
    for (i in [missesTxt,scoreTxt,accuracyTxt]){
        i.font = "fonts/papyrus.ttf";
        i.size = 25;
    }
    scoreTxt.x += 25;
    accuracyTxt.x -= 100;
}