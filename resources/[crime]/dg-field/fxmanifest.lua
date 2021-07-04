fx_version 'adamant'

game 'gta5'

description 'DG Development custom Drug System'

version '2.1.3'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua'
}

client_scripts {

	'config.lua',
	'client/weed.lua',
	'client/coke.lua'
}