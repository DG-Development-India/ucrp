fx_version 'adamant'
game 'gta5'

server_scripts {
	'functions/server.lua',
    'config.lua',
    'code/server.lua'
}

client_scripts {
	'functions/client.lua',
    'config.lua',
    'code/client.lua'
}

exports {
    'GetDamages',
    'SetDamages',
}