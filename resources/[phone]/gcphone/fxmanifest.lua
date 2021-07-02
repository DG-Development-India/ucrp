 fx_version 'adamant'
game 'gta5'

ui_page 'html/index.html'


files {
	'html/index.html',
	'html/static/css/app.css',
	'html/static/js/app.js',
	'html/static/js/manifest.js',
	'html/static/js/vendor.js',
	'html/static/config/config.json',
	
	-- Coque
	
	'html/static/img/coque/blue.png',
	'html/static/img/coque/s8.png',
	'html/static/img/coque/red.png',
	'html/static/img/coque/grey.png',
	'html/static/img/coque/pink.png',
	'html/static/img/coque/no_cover.png',
	
	-- Background
	
	'html/static/img/background/back001.jpg',
	'html/static/img/background/back002.jpg',
	'html/static/img/background/back003.jpg',
	'html/static/img/background/back004.jpg',
	'html/static/img/background/back005.jpg',
	
	'html/static/img/icons_app/call.png',
	'html/static/img/icons_app/contacts.png',
	'html/static/img/icons_app/ff.png',
	'html/static/img/icons_app/itunes.svg',
	'html/static/img/icons_app/lsfd.png',
	'html/static/img/icons_app/sms.png',
	'html/static/img/icons_app/settings.png',
	'html/static/img/icons_app/menu.png',
	'html/static/img/icons_app/bourse1.png',
	'html/static/img/icons_app/tchat.png',
	'html/static/img/icons_app/photo.png',
	'html/static/img/icons_app/policia.png',
	'html/static/img/icons_app/reddit.png',
	'html/static/img/icons_app/notes.png',
	'html/static/img/icons_app/banco.png',
	'html/static/img/icons_app/wifi.png',
	'html/static/img/icons_app/9gag.png',
	'html/static/img/icons_app/twitter.png',
	'html/static/img/icons_app/borrado.png',
	
	'html/static/img/app_bank/fleeca_tar.png',
	'html/static/img/app_bank/tarjetas.png',

	'html/static/img/app_tchat/reddit.png',

	'html/static/img/twitter/bird.png',
	'html/static/img/twitter/default_profile.png',
	'html/static/sound/Twitter_Sound_Effect.ogg',

	'html/static/img/courbure.png',
	'html/static/fonts/fontawesome-webfont.eot',
	'html/static/fonts/fontawesome-webfont.ttf',
	'html/static/fonts/fontawesome-webfont.woff',
	'html/static/fonts/fontawesome-webfont.woff2',

	'html/static/sound/deathbed.ogg',
	'html/static/sound/Drdre8bit.ogg',
	'html/static/sound/kaer_morhen.ogg',
	'html/static/sound/mountains.ogg',
	'html/static/sound/ritviz_liggi.ogg',
	'html/static/sound/ritviz_sage.ogg',
	'html/static/sound/tchatNotification.ogg',
	'html/static/sound/Phone_Call_Sound_Effect.ogg',

}

client_script {
	"config.lua",
	"client/animation.lua",
	"client/client.lua",
	"client/photo.lua",
	"client/app_tchat.lua",
	"client/bank.lua",
	"client/twitter.lua"
}

server_script {
	'@mysql-async/lib/MySQL.lua',
	"config.lua",
	"server/server.lua",
	"server/app_tchat.lua",
	"server/twitter.lua"
}
