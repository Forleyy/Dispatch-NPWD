-- LSPD
exports.npwd:onMessage('lspd', function(ctx) -- On detecte le numéro d'entreprise 

   print("ctx", json.encode(ctx, { indent = true})) -- Check console du message reçu si besoin 

TriggerEvent('sao_dispatch:police', ctx) -- On envois vers la fonction de msg d'entreprise 
end)


RegisterNetEvent("sao_dispatch:police", function(ctx)
    local src = ctx.source
    local sender = exports.qbx_core:GetPlayer(src)
    local coords = ctx.data.coords -- On prend les coords depuis ctx si pas un joueur
    local message = ctx.data.message
    local phoneNumber = ctx.data.sourcePhoneNumber or "Inconnu"
    local name = "Inconnu"

    if sender then
        local ped = GetPlayerPed(src)
        coords = GetEntityCoords(ped)
        name = sender.PlayerData.charinfo.lastname .. " " .. sender.PlayerData.charinfo.firstname
    end
    local players = exports.qbx_core:GetQBPlayers()

    for _, v in pairs(players) do
        if v.PlayerData.job.type == 'leo' then
            exports.npwd:emitMessage({
                senderNumber = "Standard 911",
                targetNumber = v.PlayerData.charinfo.phone,
                message = ("🚔 - Nouveau Message - 📃: %s - 📱: %s - 🪪: %s"):format(message, phoneNumber, name),
                embed = {
                    type = "location",
                    coords = { coords.x, coords.y, coords.z },
                    phoneNumber = phoneNumber
                }
            })
        end
    end
end)


-- EMS
exports.npwd:onMessage('ems', function(ctx, src) -- On detecte le numéro d'entreprise 

  
 
 TriggerEvent('sao_dispatch:ems', ctx) -- On envois vers la fonction de msg d'entreprise 
 end)
 
 
 RegisterNetEvent("sao_dispatch:ems", function(ctx)
     local src = ctx.source
     local ped = GetPlayerPed(src)
     local coords = GetEntityCoords(ped)
     local players = exports.qbx_core:GetQBPlayers()
 
     for _, v in pairs(players) do
      if v.PlayerData.job.type == 'ems' and v.PlayerData.job.onduty then -- check du job type 
        exports.npwd:emitMessage({
        senderNumber = "Standard 911", -- Numéro sous le quel va s'afficher le message
        targetNumber = v.PlayerData.charinfo.phone,
        message = "🚔 - Nouveau Message - " ..  "📃: " .. ctx.data.message .. " - " .. "📱: "..ctx.data.sourcePhoneNumber,
        embed = { -- si pôsition à ajouter dans le message
         type = "location",
          coords = { coords.x, coords.y, coords.z},
          phoneNumber = ctx.data.sourcePhoneNumber
         },
        })
 
       print("Emit", json.encode(ctx, { indent = true}))  -- Check console du message envoyé si besoin 
      end
     end
 end)


    -- Ajout du contact de la centrale au recrutement : 
    RegisterNetEvent("sao_dispatch:addcentral", function(source)
 
 
        local src = source
        local citizenId = exports.qbx_core:GetPlayer(src).PlayerData.citizenid
        local players = exports.qbx_core:GetQBPlayers()
    
        for _, v in pairs(players) do
            if v.PlayerData.job.type == 'leo' or v.PlayerData.job.type == 'ems' then
                MySQL.scalar('SELECT COUNT(*) FROM npwd_phone_contacts WHERE identifier = ? AND number = ?', {
                    citizenId, 'Standard 911' 
                }, function(contactExists)  
                    if contactExists and contactExists > 0 then
                        print('Le joueur a déjà le contact de la police.')
                    else
                        if v.PlayerData.job.type == 'leo' then
                            TriggerClientEvent('sao_dispatch:fillcontactlspd', src)
                        elseif v.PlayerData.job.type == 'ems' then
                            TriggerClientEvent('sao_dispatch:fillcontactems', src)
                        end
                        print('Ajout du contact.')
                    end
                end)
            end
        end
    
    end)

-- Appel vocal urgence indispo 

exports.npwd:onCall("911", function(ctx)

        ctx.reply("Désolé, par manque de budget les urgences sont en SMS uniquement. Merci de votre compréhenssions.")
        ctx.exit()

end)

exports.npwd:onCall("lspd", function(ctx)

    ctx.reply("Désolé, par manque de budget les urgences sont en SMS uniquement. Merci de votre compréhenssions.")
    ctx.exit()

end)
exports.npwd:onCall("ems", function(ctx)

    ctx.reply("Désolé, par manque de budget les urgences sont en SMS uniquement. Merci de votre compréhenssions.")
    ctx.exit()

end)