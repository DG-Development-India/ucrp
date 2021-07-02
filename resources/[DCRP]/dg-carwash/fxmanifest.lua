fx_version 'adamant'
games { 'gta5' }

server_scripts {
	'@dg-core/locale.lua',
	'locales/en.lua',
	'locales/sv.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@dg-core/locale.lua',
	'locales/en.lua',
	'locales/sv.lua',
	'config.lua',
	'client/main.lua'
}

dependency 'dg-core'