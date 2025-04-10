fx_version 'cerulean'
game 'gta5'
version '1.0'
creator 'pawal'
lua54 'yes'

client_scripts {
    'config.lua',
    'client/framework/*.lua',
    'locale.lua',
    'client/*.lua'
}

shared_scripts {
    '@ox_lib/init.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/img/**/*',
}