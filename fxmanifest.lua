fx_version("cerulean")
game("gta5")
description("Systeme de dispatch SAO")
authors({ "Forley" })
version("1.0")

client_script {
    'dispatch_c.lua',
    '@qbx_core/modules/playerdata.lua'
}

server_script({
    '@oxmysql/lib/MySQL.lua',
	"dispatch_s.lua"
  
})

