import funkin.backend.utils.DiscordUtil;

function onMenuLoaded() {
	DiscordUtil.changePresenceAdvanced({
		state: "menu",
		details: "a menu",
		smallImageKey: "https://media.tenor.com/Iqj4GVV1M4sAAAAj/mizuki-akiyama-mizuki.gif"
	});
}

function onGameOver() {
	DiscordUtil.changePresenceAdvanced({
        largeImageKey: "https://c.tenor.com/JW71Wtti2gcAAAAd/tenor.gif"
	});
}

function onPlayStateUpdate() {
	DiscordUtil.changePresenceAdvanced({
		state: (PlayState.instance.paused ? "Paused - " : "") + PlayState.SONG.meta.displayName,
		details: 'Score:' + PlayState.instance.songScore + ' | Misses:' + PlayState.instance.misses,
        largeImageKey: PlayState.SONG.meta.name,
		smallImageKey: "https://media.tenor.com/Iqj4GVV1M4sAAAAj/mizuki-akiyama-mizuki.gif"
	});
}

function onDiscordPresenceUpdate(e) {
	var data = e.presence;

	data.button1Label = "";
	data.button1Url = "";
}