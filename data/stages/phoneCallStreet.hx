import openfl.display.BlendMode;
import flixel.addons.display.FlxBackdrop;

function postCreate(){
    insert(0,bgSky = new FlxBackdrop(Paths.image('stages/phoneCallStreet/sky'), 0x01));
    bgSky.setPosition(-1885.85, -100);
	bgSky.scrollFactor.set(0.1, 0.1);
	bgSky.velocity.x = 20;
	bgSky.scale.set(1.2, 1.2);

    for(i in [standhousesFAR,standhouseBACK,standhouseBushesBACK,standback,standpillar,standlamp,standbushesR,standbushesL]){
        i.alpha = 0.001;
    }
    standbushesL.scale.y = 1.5;
    lightShade.scale.x = 1882.6 * 3;
    lightShade.updateHitbox();
    lightShade.alpha = 0.1;

    overlayall.scale.x = 1280 * 2;
    overlayall.updateHitbox();
    overlayall.blend = BlendMode.ADD;
    overlayall.alpha = 0.1;
}