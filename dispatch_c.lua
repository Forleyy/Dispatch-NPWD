-- LSPD
RegisterNetEvent("sao_dispatch:fillcontactlspd", function(src)
    local contact = {
        name = 'Standard 911',
        number = 'Standard 911',
        avatar = 'https://i.ibb.co/dsg5bLP2/BTmvvEw.png'
    }
    exports.npwd:fillNewContact(contact)
end)

-- EMS 
RegisterNetEvent("sao_dispatch:fillcontactems", function(src)
    local contact = {
        name = 'Standard 911',
        number = 'Standard 911',
        avatar = 'https://i.ibb.co/xK8hMXQY/LOGO.png'
    }
    exports.npwd:fillNewContact(contact)
end)

