fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'A5-SCRIPTS'
description 'Standalone Camera Mode'
version '1.0'

shared_scripts {
	'shared/sh_config.lua',
}

client_scripts {
    'client/*.lua',
}

ui_page 'html/ui.html'

files {
    'html/ui.html',
	'html/js/*.js',
	'html/css/*.css',
	'html/images/*.png',
	'html/images/*.jpg',
	'html/audios/*.mp3',
}

dependencies {
	'screenshot-basic'
}




