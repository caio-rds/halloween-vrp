-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
uRP = {}
Tunnel.bindInterface("halloween",uRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK - LOGs
-----------------------------------------------------------------------------------------------------------------------------------------
local wb_hw = ''
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local items = {
    [1] = {'pumpkin'},
    [2] = {'plastic-bat'},
    [3] = {'sweet-bucket'}
} -- NEED TO CREATE THIS ITENS IN MODULES
-----------------------------------------------------------------------------------------------------------------------------------------
-- GIVE BONUS
-----------------------------------------------------------------------------------------------------------------------------------------
function uRP.getBonus()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local rand = math.random(#items)
        if vRP.getPremium(user_id) then
            vRP.giveInventoryItem(user_id, items[parseInt(rand)][1], 2, true)
            vRP._createWeebHook(wb_hw,'```[ID]: '..user_id..'\n[RECEBEU] 2x '..vRP.itemNameList(items[parseInt(rand)][1])..' ('..items[parseInt(rand)][1]..')'..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S")..'```')
        else 
            vRP.giveInventoryItem(user_id, items[parseInt(rand)][1], 1, true)
            vRP._createWeebHook(wb_hw,'```[ID]: '..user_id..'\n[RECEBEU] 1x '..vRP.itemNameList(items[parseInt(rand)][1])..' ('..items[parseInt(rand)][1]..')'..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S")..'```')
        end                        
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TABLE ITENS
-----------------------------------------------------------------------------------------------------------------------------------------
local give_itens = {
    ['COPS'] = {
        [1] = {"vest",1},
        [2] = {"WEAPON_PISTOL_AMMO",12},
        [3] = {"dollars",2000},
        [4] = {"WEAPON_COMBATPISTOL",1}        
    },
    ['ILEGALS'] = {
        [1] = { "cocaine",5 },
        [2] = { "weed",5 },
        [3] = { "c4",1 },
        [4] = { "cpuchip",1 },
        [5] = { "vest",1 },
        [6] = { "hoodie",1 },
        [7] = { "handcuff",1 },
        [8] = { "bluecard",2 },
        [9] = { "blackcard",1 }
    },
    ['GUNS'] = {
        [1] = { "WEAPON_ASSAULTSMG",1 },
        [2] = { "WEAPON_COMPACTRIFLE",1 },
        [3] = { "WEAPON_MINISMG",1 },
        [4] = { "WEAPON_ASSAULTRIFLE",1 },
        [5] = { "WEAPON_PUMPSHOTGUN",1 },
        [6] = { "WEAPON_ASSAULTSMG",1 },
        [7] = { "WEAPON_RIFLE_AMMO",60 },
        [8] = { "WEAPON_SMG_AMMO",60 },
        [9] = { "WEAPON_PISTOL_AMMO",24 }
    },
    ['4ALL'] = {
        [1] = { "dollars",500 },
        [2] = { "aluminium",10 },
        [3] = { "rubber",10 },
        [4] = { "copper",10 },
        [5] = { "glass",10 },
        [6] = { "plastic",10 },
        [7] = { "hamburger",3 },
        [8] = { "hotdog",3 },
        [9] = { "cola3l",2 },
        [10] = { "energetic",3 },
        [11] = { "lighter", 1 },
        [12] = { "fishingrod", 1 },
        [13] = { "vape", 1 },
        [14] = { "divingsuit", 1 },
        [15] = { "warfarin", 1 },
        [16] = { "gauze", 1 },
        [17] = { "bandage", 1 },
        [18] = { "analgesic", 1 },
        [19] = { "sinkalmy", 1 },
        [20] = { "ritmoneury", 1 },
        [21] = { "adrenaline", 1 },
        [22] = { "cigarrete", 10 },
        [23] = { "joint", 5 },
        [24] = { "lean", 5 },
        [25] = { "lockpick", 1 },
        [26] = { "toolbox", 1 },
        [27] = { "tires", 1 },
        [28] = { "backpack", 1 }
    },
    ['PREMIUM'] = {
        [1] = { "premium02",1 },
        [2] = { "premiumgarage",1 },
        [3] = { "premiumplate",1 }
    }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- OPEN BONUS - GIVE ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('open:Halloween')
AddEventHandler('open:Halloween',
    function(source,user_id)
        if user_id and source then
            local rand_chance = math.random(100)
            if rand_chance < 75 then -- THIS IS THE CONDITIONAL TO DECIDE IF ITEM WILL BE BASED IN PROFISSION OR NOT

                local rand_item = math.random(#give_itens['4ALL'])
    
                vRP.giveInventoryItem(user_id, give_itens['4ALL'][parseInt(rand_item)][1],give_itens['4ALL'][parseInt(rand_item)][2],true)

            else
                if vRP.hasPermission(user_id,'Police') or vRP.hasPermission(user_id,'waitPolice') then -- CHECK TO SEE IF PLAYER IS A COP

                    local rand_item = math.random(#give_itens['COPS'])                   
                    vRP.giveInventoryItem(user_id, give_itens['COPS'][parseInt(rand_item)][1],give_itens['COPS'][parseInt(rand_item)][2],true)

                elseif vRP.hasPermission(user_id,'Paramedic') or vRP.hasPermission(user_id,'waitParamedic') or -- CHECK TO SEE IF PLAYER IS A MEDIC OR MECHANIC
                    vRP.hasPermission(user_id,'Mechanic') or vRP.hasPermission(user_id,'waitMechanic') then

                    local rand_item = math.random(#give_itens['4ALL'])

                    vRP.giveInventoryItem(user_id, give_itens['4ALL'][parseInt(rand_item)][1],give_itens['4ALL'][parseInt(rand_item)][2],true)

                else
                    local rand_ilegal = math.random(100)
                    if rand_ilegal > 95 then -- CASE RANDOM >= 95 THEN PLAYER WILL GET A GUN

                        local rand_item = math.random(#give_itens['GUNS'])
                     
                        vRP.giveInventoryItem(user_id, give_itens['GUNS'][parseInt(rand_item)][1],give_itens['GUNS'][parseInt(rand_item)][2],true)

                    elseif rand_ilegal > 75 and rand_item <= 94 then

                        local rand_item = math.random(#give_itens['ILEGALS']) -- CASE RANDOM >= 75 THEN PLAYER WILL GET A ILLEGAL ITEM (TO ROB)
               
                        vRP.giveInventoryItem(user_id, give_itens['ILEGALS'][parseInt(rand_item)][1],give_itens['ILEGALS'][parseInt(rand_item)][2],true)
                        
                    else

                        local rand_item = math.random(#give_itens['4ALL']) -- WILL GIVE A NORMAL ITEM (TO EVERYONE)
               
                        vRP.giveInventoryItem(user_id, give_itens['4ALL'][parseInt(rand_item)][1],give_itens['4ALL'][parseInt(rand_item)][2],true)

                    end
                end                
            end

            if rand_chance > 98 then
                local rand_item = math.random(#give_itens['PREMIUM'])
                vRP.giveInventoryItem(user_id, give_itens[parseInt(rand_item)][1],give_itens[parseInt(rand_item)][2],true)
            end
        end
    end
)


-----------------------------------------------------------------------------------------------------------------------------------------
-- CODEBLOCKS TO TRIGGER EVENT (PUT IN INVENTORY)
-----------------------------------------------------------------------------------------------------------------------------------------

-- if itemName == "pumpkin" or itemName == "sweet-bucket" or itemName == "plastic-bat" then
--     if vRP.computeInvWeight(user_id) + 5 <= vRP.getBackpack(user_id) then
--         active[user_id] = 5
--         vCLIENT.closeInventory(source)
--         vCLIENT.blockButtons(source,true)
--         TriggerClientEvent('Progress',source,5000)
        
--         repeat 
--             if active[user_id] == 0 then
--                 active[user_id] = nil
--                 vCLIENT.blockButtons(source,false)
--                 if vRP.tryGetInventoryItem(user_id,itemName,1,true,slot) then
--                     TriggerEvent("open:Halloween",source,user_id)
--                 end
--             end
--         Citizen.Wait(0)
--         until active[user_id] == nil
--     else
--         TriggerClientEvent("Notify",source,"vermelho","Mochila cheia",8000)
--     end
-- end