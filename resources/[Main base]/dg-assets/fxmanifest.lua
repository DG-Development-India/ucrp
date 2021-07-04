fx_version 'adamant'
games { 'gta5' }

client_scripts {
    'config.lua',
    'client.lua',
    'blips.lua',
    'jobblips.lua',
    'items.lua',
    'shops.lua',
    'prone.lua',
    'teleports.lua',
    'propattach.lua',
    'status.lua',
    'heli_client.lua',
    'gym.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server.lua',
    'binoserver.lua',
    'heli_server.lua'
}