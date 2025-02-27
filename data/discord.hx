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